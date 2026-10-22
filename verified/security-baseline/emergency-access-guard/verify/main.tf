# Reads the Conditional Access policies back and fails when a checked policy does not exclude
# every emergency access user and group. Read-only: the module sends no Graph writes. See:
# https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access#conditional-access-considerations

locals {
  policy_ids     = sort(var.baseline_policy_ids)
  exclude_users  = sort(var.exclusions.excludeUsers)
  exclude_groups = sort(var.exclusions.excludeGroups)

  policies = { for policy in try(data.msgraph_resource.policies[0].output.policies, []) : lower(policy.id) => policy }

  # The free tier reads no policies; the tier precondition rejects policy IDs instead.
  missing_policy_ids = [for id in local.policy_ids : id if var.tier != "free" && !contains(keys(local.policies), id)]

  # Baseline policies in every state, because one input change moves a report-only baseline
  # policy to enforced. In tenant scope also every enabled policy, including Microsoft-managed
  # policies; report-only and disabled policies outside the baseline need no exclusion.
  checked_policy_ids = sort(distinct(concat(
    [for id in local.policy_ids : id if contains(keys(local.policies), id)],
    var.scope == "tenant" ? [for id, policy in local.policies : id if try(policy.state, null) == "enabled"] : [],
  )))

  unsupported_policy_ids = [for id in local.checked_policy_ids : id
    if try(local.policies[id].conditions.users, null) == null
  ]

  missing_exclusions = {
    for id in local.checked_policy_ids : id => {
      users  = sort(setsubtract(local.exclude_users, try([for user in local.policies[id].conditions.users.excludeUsers : lower(user)], [])))
      groups = sort(setsubtract(local.exclude_groups, try([for group in local.policies[id].conditions.users.excludeGroups : lower(group)], [])))
    } if !contains(local.unsupported_policy_ids, id)
  }

  policy_errors = [
    for id, missing in local.missing_exclusions :
    "Policy ${substr(id, 0, 4)}...${substr(id, -4, 4)}, state ${try(local.policies[id].state, "unknown")}${contains(local.policy_ids, id) ? "" : ", outside the baseline"}: ${join("; ", compact([
      length(missing.users) == 0 ? "" : "excludeUsers lacks ${join(", ", [for user in missing.users : "${substr(user, 0, 4)}...${substr(user, -4, 4)}"])}",
      length(missing.groups) == 0 ? "" : "excludeGroups lacks ${join(", ", [for group in missing.groups : "${substr(group, 0, 4)}...${substr(group, -4, 4)}"])}",
    ]))}."
    if length(missing.users) + length(missing.groups) > 0
  ]

  tier_error      = "Tier free runs no Conditional Access checks, because security defaults stay on and Conditional Access needs Microsoft Entra ID P1, but baseline_policy_ids lists ${join(", ", [for id in local.policy_ids : "${substr(id, 0, 4)}...${substr(id, -4, 4)}"])}. Remove them, or use p1 or p2."
  missing_error   = "Baseline policies not found in the tenant: ${join(", ", [for id in local.missing_policy_ids : "${substr(id, 0, 4)}...${substr(id, -4, 4)}"])}."
  exclusion_error = "Conditional Access policies do not exclude every emergency access account. ${join(" ", local.policy_errors)}"
}

# Holds the baseline policy IDs and the exclusions so that the read below waits for them. When
# they are unknown or change, for example on the first apply of the baseline or when a
# break-glass account is added, this gate has a planned change and Terraform defers the read to
# apply. This local gate does not establish an edge to an external policy writer: callers
# that update policies must set depends_on on this verifier module for the writer. With no
# writer changes and unchanged inputs, reads happen at plan time so drift fails the plan.
resource "terraform_data" "baseline_policy_ids" {
  input = sensitive({
    policy_ids     = local.policy_ids
    exclude_users  = local.exclude_users
    exclude_groups = local.exclude_groups
  })
}

data "msgraph_resource" "policies" {
  count = var.tier == "free" ? 0 : 1

  url         = "identity/conditionalAccess/policies"
  api_version = "v1.0"

  query_parameters = {
    "$select" = ["id,displayName,state,conditions"]
  }

  response_export_values = {
    policies  = "value"
    next_link = "\"@odata.nextLink\""
  }

  depends_on = [terraform_data.baseline_policy_ids]

  lifecycle {
    postcondition {
      condition = try(
        self.output.policies != null && can(concat(self.output.policies, [])) &&
        contains(keys(self.output), "next_link") && self.output.next_link == null &&
        length(distinct([for policy in self.output.policies : lower(policy.id)])) == length(self.output.policies) &&
        alltrue([for policy in self.output.policies :
          can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", policy.id)) &&
          contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], policy.state) &&
          # User exclusions are relevant only to the checked population. Workload policies
          # have clientApplications instead; the gate refuses those explicitly below.
          (!(contains(local.policy_ids, lower(policy.id)) || (var.scope == "tenant" && policy.state == "enabled")) ||
            try(policy.conditions.users, null) == null || try(
              can(concat(policy.conditions.users.excludeUsers, [])) && policy.conditions.users.excludeUsers != null &&
              alltrue([for id in policy.conditions.users.excludeUsers : id != null && id == tostring(id)]) &&
              can(concat(policy.conditions.users.excludeGroups, [])) && policy.conditions.users.excludeGroups != null &&
              alltrue([for id in policy.conditions.users.excludeGroups : id != null && id == tostring(id)]), false
          ))
        ]), false
      )
      error_message = "The policy response is malformed, incomplete or still paginated; emergency access exclusions are not verified."
    }
  }
}

# The gate holds no tenant state. Its preconditions name each failing policy and the missing IDs.
resource "terraform_data" "verified" {
  input = sensitive({
    scope               = var.scope
    baseline_policy_ids = local.policy_ids
  })

  lifecycle {
    precondition {
      condition     = var.tier != "free" || length(local.policy_ids) == 0
      error_message = nonsensitive(sensitive(local.tier_error))
    }

    precondition {
      condition     = var.tier == "free" || var.scope != "baseline" || length(local.policy_ids) > 0
      error_message = "Non-free baseline verification requires at least one baseline_policy_ids entry. Use tenant scope explicitly to check the enabled user-policy population instead."
    }

    precondition {
      condition     = length(local.missing_policy_ids) == 0
      error_message = nonsensitive(sensitive(local.missing_error))
    }

    precondition {
      condition     = length(local.unsupported_policy_ids) == 0
      error_message = nonsensitive(sensitive("Checked policies without user conditions are outside this verifier's supported scope: ${join(", ", [for id in local.unsupported_policy_ids : "${substr(id, 0, 4)}...${substr(id, -4, 4)}"])}. Workload-identity policies require a separate applicability review."))
    }

    precondition {
      condition     = length(local.policy_errors) == 0
      error_message = nonsensitive(sensitive(local.exclusion_error))
    }
  }
}
