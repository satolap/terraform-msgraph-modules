locals {
  combinations = sort(tolist(var.allowedCombinations))
  metadata_body = merge(
    { displayName = var.displayName },
    var.description == null ? {} : { description = var.description },
  )
  configurations = merge(
    var.allowedAAGUIDs == null ? {} : {
      fido2 = {
        "@odata.type"         = "#microsoft.graph.fido2CombinationConfiguration"
        appliesToCombinations = ["fido2"]
        allowedAAGUIDs        = sort(distinct([for value in var.allowedAAGUIDs : lower(value)]))
      }
    },
    { for combination, restrictions in var.x509CertificateCombinationConfigurations : combination => merge(
      {
        "@odata.type"         = "#microsoft.graph.x509CertificateCombinationConfiguration"
        appliesToCombinations = [combination]
      },
      { for key, values in restrictions : key => key == "allowedIssuerSkis" ? sort(distinct([for value in values : lower(value)])) : sort(tolist(values)) },
    ) },
  )
}

# A create-only action cannot adopt an existing or built-in strength. In-place
# changes never resend POST; separate writers handle metadata and combinations.
resource "msgraph_resource_action" "policy" {
  resource_url           = "policies/authenticationStrengthPolicies"
  api_version            = "v1.0"
  method                 = "POST"
  body                   = merge(local.metadata_body, { allowedCombinations = local.combinations })
  response_export_values = { policy = "@" }

  lifecycle {
    ignore_changes = all

    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.displayName))
      error_message = "displayName \"${var.displayName}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set displayName to a value that matches, or change name_pattern."
    }

    postcondition {
      condition = try(alltrue([
        can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", self.output.policy.id)),
        self.output.policy.policyType == "custom",
      ]), false)
      error_message = "Graph must return the newly created policy GUID and policyType custom. Built-in strengths are read-only; missing or different ownership evidence is refused."
    }
  }
}

# Independent GET verifies the exact created identity before registering DELETE
# or permitting any subsequent writer. No existing-policy selector is exposed.
data "msgraph_resource" "verify" {
  url                    = "${msgraph_resource_action.policy.resource_url}/${msgraph_resource_action.policy.output.policy.id}"
  api_version            = "v1.0"
  response_export_values = { policy = "@" }

  lifecycle {
    postcondition {
      condition = try(alltrue([
        self.output.policy.id == msgraph_resource_action.policy.output.policy.id,
        self.output.policy.policyType == "custom",
      ]), false)
      error_message = "Independent GET must verify the created policy ID and custom type. Deletion registration and updates fail closed."
    }
  }
}

resource "terraform_data" "owned" {
  input      = { policyId = msgraph_resource_action.policy.output.policy.id }
  depends_on = [data.msgraph_resource.verify]

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [msgraph_resource_action.policy]
  }
}

# Registration sends nothing. The provider deletes only the captured item URL
# on destroy; a Graph reference error is returned to Terraform without bypass.
resource "msgraph_resource_action" "remove" {
  resource_url = "policies/authenticationStrengthPolicies/${terraform_data.owned.input.policyId}"
  api_version  = "v1.0"
  method       = "DELETE"
  when         = "destroy"
  # Destroy the policy before touching its restrictions. If a CA reference
  # blocks deletion, the child configurations must remain intact.
  # This also delays registration until those writers succeed: after a failed
  # first apply, repair and re-apply before destroy (see README recovery warning).
  depends_on = [msgraph_resource.configuration, msgraph_update_resource.metadata, msgraph_resource_action.combinations]

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.owned]

    precondition {
      condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", terraform_data.owned.input.policyId))
      error_message = "Refusing deletion registration without the saved policy GUID."
    }
  }
}

resource "msgraph_update_resource" "metadata" {
  url           = "policies/authenticationStrengthPolicies/${terraform_data.owned.input.policyId}"
  api_version   = "v1.0"
  update_method = "PATCH"
  body          = local.metadata_body
  depends_on    = [terraform_data.transition]

  lifecycle {
    replace_triggered_by = [msgraph_resource_action.policy]
  }
}

resource "terraform_data" "combinations" {
  input = local.combinations
}

# Replacing this action invokes the documented idempotent setter once. A
# normal update cannot resubmit POST, and destroying the action sends nothing.
resource "msgraph_resource_action" "combinations" {
  resource_url           = "policies/authenticationStrengthPolicies/${terraform_data.owned.input.policyId}/updateAllowedCombinations"
  api_version            = "v1.0"
  method                 = "POST"
  body                   = { allowedCombinations = local.combinations }
  response_export_values = { result = "@" }
  depends_on             = [terraform_data.transition]

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.combinations, msgraph_resource_action.policy]
  }
}

# The generic PATCH table documents only appliesToCombinations. Restriction
# changes conservatively replace the child, deleting the old configuration first.
resource "terraform_data" "configuration" {
  for_each = local.configurations
  input    = each.value
}

resource "msgraph_resource" "configuration" {
  for_each    = local.configurations
  url         = "policies/authenticationStrengthPolicies/${terraform_data.owned.input.policyId}/combinationConfigurations"
  api_version = "v1.0"
  body        = each.value
  depends_on  = [msgraph_resource_action.combinations]

  response_export_values = { configuration = "@" }

  lifecycle {
    ignore_changes       = [body]
    replace_triggered_by = [terraform_data.configuration[each.key], msgraph_resource_action.policy]

    precondition {
      condition     = contains(var.allowedCombinations, each.key)
      error_message = "Each configuration must apply to a combination present in allowedCombinations."
    }

    postcondition {
      condition = try(alltrue([
        can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", self.output.configuration.id)),
        self.output.configuration.id == self.id,
        alltrue([for key, value in each.value : key == "@odata.type" ? self.output.configuration[key] == value : (
          contains(["allowedAAGUIDs", "allowedIssuerSkis"], key) ? sort(distinct([for identifier in self.output.configuration[key] : lower(identifier)])) == sort(tolist(value)) : sort(tolist(self.output.configuration[key])) == sort(tolist(value))
        )]),
      ]), false)
      error_message = "Graph did not return the created configuration ID, concrete type and desired restrictions. Investigate drift before replacing a child, with CA references detached."
    }
  }
}

# A changed desired set defers this independent GET until after the setter.
# Otherwise it detects drift hidden by the create-only action's ignore_changes.
data "msgraph_resource" "current" {
  url                    = "policies/authenticationStrengthPolicies/${terraform_data.owned.input.policyId}"
  api_version            = "v1.0"
  response_export_values = { policy = "@" }
  depends_on             = [msgraph_update_resource.metadata, msgraph_resource_action.combinations, msgraph_resource.configuration]

  lifecycle {
    postcondition {
      condition = try(alltrue([
        self.output.policy.id == terraform_data.owned.input.policyId,
        self.output.policy.policyType == "custom",
        sort(distinct([for combination in self.output.policy.allowedCombinations : join(",", [for flag in split(",", combination) : trimspace(flag)])])) == local.combinations,
      ]), false)
      error_message = "Independent read did not return the owned custom policy and desired allowedCombinations. Investigate replication or drift; only the idempotent combinations setter may be explicitly replaced to repair confirmed combination drift."
    }
  }
}
