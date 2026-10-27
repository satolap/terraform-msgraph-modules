# No pinned contract establishes pre-staging restrictions, updating their values
# in place, or overlapping configurations. Read before the writers, never after
# them: a referenced strength must retain the same combinations and restrictions.
data "msgraph_resource" "usage" {
  url                    = "policies/authenticationStrengthPolicies/${msgraph_resource_action.policy.output.policy.id}/usage"
  api_version            = "v1.0"
  response_export_values = { usage = "@" }
  depends_on             = [data.msgraph_resource.verify]
}

data "msgraph_resource" "configurations" {
  url                    = "policies/authenticationStrengthPolicies/${msgraph_resource_action.policy.output.policy.id}/combinationConfigurations"
  api_version            = "v1.0"
  response_export_values = { collection = "@" }
  depends_on             = [data.msgraph_resource.verify]
}

locals {
  usage = try(data.msgraph_resource.usage.output.usage, null)
  usage_complete = try(alltrue([
    startswith(jsonencode(local.usage.mfa), "["),
    startswith(jsonencode(local.usage.none), "["),
    alltrue([for key, value in local.usage : endswith(key, "@odata.nextLink") ? value == null : true]),
  ]), false)
  usage_empty = try(alltrue([
    jsonencode(local.usage.mfa) == "[]",
    jsonencode(local.usage.none) == "[]",
  ]), false)
  observed_combinations = try(sort(distinct([
    for combination in data.msgraph_resource.verify.output.policy.allowedCombinations :
    join(",", [for flag in split(",", combination) : trimspace(flag)])
  ])), null)
  observed_configurations = try({
    for configuration in data.msgraph_resource.configurations.output.collection.value :
    join(",", sort(tolist(configuration.appliesToCombinations))) => merge(
      {
        "@odata.type"         = configuration["@odata.type"]
        appliesToCombinations = sort(tolist(configuration.appliesToCombinations))
      },
      {
        for key in ["allowedAAGUIDs", "allowedIssuerSkis", "allowedPolicyOIDs"] : key => (
          contains(["allowedAAGUIDs", "allowedIssuerSkis"], key) ? sort(distinct([
            for value in configuration[key] : lower(value)
          ])) : sort(tolist(configuration[key]))
        ) if try(length(configuration[key]) > 0, false)
      },
    )
  }, null)
  snapshot_complete = try(alltrue([
    local.observed_combinations != null,
    local.observed_configurations != null,
    startswith(jsonencode(data.msgraph_resource.configurations.output.collection.value), "["),
    alltrue([for key, value in data.msgraph_resource.configurations.output.collection : endswith(key, "@odata.nextLink") ? value == null : true]),
  ]), false)
  restrictions_unchanged = alltrue([
    jsonencode(local.observed_combinations) == jsonencode(local.combinations),
    jsonencode(local.observed_configurations) == jsonencode(local.configurations),
  ])
  # input contains the NEW planned value. output is the persisted value on a
  # no-op, and becomes unknown when the helper input changes. Do not allow that
  # unknown to defer a referenced replacement past the helper's update.
  saved_configurations_unchanged = jsonencode(local.configurations) == jsonencode({
    for name, configuration in terraform_data.configuration : name => configuration.output
  })
}

# Terraform has no expression that tests whether a value is known in a plan.
# Requiring known instance keys makes a planned child replacement or signature
# update fail before APPLY, instead of evaluating a guard against updated state.
# Maintenance bypasses this plan-only check, but MUST prove detachment below.
# Keep this independent of transition's dependencies: it reads planned children,
# so making the writers depend on it would introduce a cycle.
resource "terraform_data" "stable_configuration_plan" {
  for_each = var.detached_maintenance ? {} : {
    for name, configuration in msgraph_resource.configuration :
    "${name}:${configuration.id}:${sha256(jsonencode(terraform_data.configuration[name].output))}" => name
  }
}

# Retain this guard even when the last configuration is removed. Independent
# reads are known during an existing policy's normal plan, so a refusal aborts
# the entire plan before child destroys as well as before the setter and creates.
resource "terraform_data" "transition" {
  lifecycle {
    precondition {
      condition     = alltrue([local.usage_complete, local.snapshot_complete])
      error_message = "Cannot establish complete authentication strength usage and restrictions. Missing, malformed or paginated evidence fails closed; resolve the read before applying."
    }
    precondition {
      condition = var.detached_maintenance ? local.usage_empty : (
        local.usage_empty ? true : alltrue([local.restrictions_unchanged, local.saved_configurations_unchanged])
      )
      error_message = "Conditional Access policies reference this strength. Detach every CA reference, apply the combination/restriction change, verify the completed restrictions, then reattach. Adding, replacing or removing restrictions while referenced can open an unrestricted authentication window."
    }
  }
}
