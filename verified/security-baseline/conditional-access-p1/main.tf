# Four Microsoft Entra Conditional Access policies that replace security defaults on a
# Microsoft Entra ID P1 or P2 tenant: MFA for administrators, block legacy authentication, MFA
# for all users and MFA for Azure management. The policies start in report-only mode. Security
# defaults are turned off only in the apply that enforces them, and a decommission apply deletes
# the policies and restores the recorded security defaults state. See the README.
#
# The policies are declared here with msgraph_resource, not through the generated module, so
# that each policy carries lifecycle postconditions on its read-back exclusions.

# Licence guard: fails the plan for a tenant without a usable P1 or P2 subscription. A
# decommission apply must still work after the licence lapsed (policies can be deleted then), so
# it neither reads licences nor checks the emergency access accounts. The condition depends only
# on the decommission input, never on licence data.
module "licence_guard" {
  source = "../licence-guard"
  count  = var.decommission ? 0 : 1

  tier          = var.tier
  allowed_tiers = ["p1", "p2"]
}

# Emergency access guard: every break-glass user must exist, and the validated, sorted user IDs
# are the exclusions of all four policies. minimum_accounts is 1 so that a single account only
# warns (check "two_emergency_access_accounts"), as Microsoft recommends two or more.
module "emergency_access" {
  source = "../emergency-access-guard"
  count  = var.decommission ? 0 : 1

  tier                  = var.tier
  break_glass_user_ids  = var.break_glass_user_ids
  break_glass_group_ids = var.break_glass_group_ids
  minimum_accounts      = 1
}

locals {
  policies_url = "identity/conditionalAccess/policies"

  # Sorted lists: the provider compares arrays by position when it refreshes a body.
  exclude_users = sort(distinct(flatten(module.emergency_access[*].exclude_users)))

  # The 14 roles of Microsoft's administrator MFA policy, plus Authentication Policy
  # Administrator and Identity Governance Administrator, which security defaults also cover.
  default_admin_roles = [
    "62e90394-69f5-4237-9190-012177145e10", # Global Administrator
    "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", # Application Administrator
    "c4e39bd9-1100-46d3-8c65-fb160da0071f", # Authentication Administrator
    "b0f54661-2d74-4c50-afa3-1ec803f12efe", # Billing Administrator
    "158c047a-c907-4556-b7ef-446551a6b5f7", # Cloud Application Administrator
    "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", # Conditional Access Administrator
    "29232cdf-9323-42fd-ade2-1d097af3e4de", # Exchange Administrator
    "729827e3-9c14-49f7-bb1b-9608f156bbb8", # Helpdesk Administrator
    "966707d0-3269-4727-9be2-8c3a10f19b9d", # Password Administrator
    "7be44c8a-adaf-4e2a-84d6-ab2649e08a13", # Privileged Authentication Administrator
    "e8611ab8-c189-46e8-94e1-60213ab1f814", # Privileged Role Administrator
    "194ae4cb-b126-40b2-bd5b-6091b380977d", # Security Administrator
    "f28a1f50-f6e7-4571-818b-6a12f2af6b6c", # SharePoint Administrator
    "fe930be7-5e62-47db-91af-98c3a49a38b1", # User Administrator
    "0526716b-113d-4c15-b2c8-68e3c22b9f80", # Authentication Policy Administrator
    "45d8d3c5-c802-45c6-b32a-1d70b5e1e86e", # Identity Governance Administrator
  ]
  admin_roles = sort(distinct(concat(local.default_admin_roles, [for id in var.additional_admin_role_template_ids : lower(id)])))

  directory_sync_role     = "d29b2b05-8046-44ba-8758-1e26182fcf32" # Directory Synchronization Accounts
  azure_management_app_id = "797f4846-ba00-4fd7-ba43-dac1f8f63013" # Windows Azure Service Management API

  state = var.enforce ? "enabled" : "enabledForReportingButNotEnforced"

  names = {
    admins           = "Require multifactor authentication for admins"
    legacy_auth      = "Block legacy authentication"
    all_users        = "Require multifactor authentication for all users"
    azure_management = "Require multifactor authentication for Azure management"
  }
  display_names = { for key, name in local.names : key => "${var.display_name_prefix}${name}" }

  # The break-glass exclusions go into every policy. Group IDs are never sent (the guard's
  # exclude_groups is empty by design), so excludeGroups is an explicit empty list.
  users_base = {
    includeUsers  = []
    excludeUsers  = local.exclude_users
    includeGroups = []
    excludeGroups = []
    includeRoles  = []
    excludeRoles  = []
  }

  bodies = {
    admins = {
      displayName = local.display_names.admins
      state       = local.state
      conditions = {
        users          = merge(local.users_base, { includeRoles = local.admin_roles })
        applications   = { includeApplications = ["All"] }
        clientAppTypes = ["all"]
      }
      grantControls = { operator = "OR", builtInControls = ["mfa"] }
    }

    legacy_auth = {
      displayName = local.display_names.legacy_auth
      state       = local.state
      conditions = {
        users          = merge(local.users_base, { includeUsers = ["All"] })
        applications   = { includeApplications = ["All"] }
        clientAppTypes = ["exchangeActiveSync", "other"]
      }
      grantControls = { operator = "OR", builtInControls = ["block"] }
    }

    all_users = {
      displayName = local.display_names.all_users
      state       = local.state
      conditions = {
        users = merge(local.users_base, {
          includeUsers = ["All"]
          excludeRoles = var.exclude_directory_sync_accounts ? [local.directory_sync_role] : []
        })
        applications   = { includeApplications = ["All"] }
        clientAppTypes = ["all"]
      }
      grantControls = { operator = "OR", builtInControls = ["mfa"] }
    }

    azure_management = {
      displayName = local.display_names.azure_management
      state       = local.state
      conditions = {
        users          = merge(local.users_base, { includeUsers = ["All"] })
        applications   = { includeApplications = [local.azure_management_app_id] }
        clientAppTypes = ["all"]
      }
      grantControls = { operator = "OR", builtInControls = ["mfa"] }
    }
  }

  # Policy keys to manage: none during a decommission apply.
  policy_keys = var.decommission ? [] : keys(local.names)

  # Enforce precondition: the four baseline policies must already exist, by display name.
  existing_names = [for policy in try(data.msgraph_resource.existing_policies[0].output.policies, []) : policy.displayName]
  missing_names  = [for key, name in local.display_names : name if !contains(local.existing_names, name)]

  # Security defaults: the value on the first apply is recorded and never overwritten.
  security_defaults_now   = try(data.msgraph_resource.security_defaults.output.is_enabled, null)
  security_defaults_prior = terraform_data.security_defaults_prior.input == true

  # Security defaults were on before the module, and are off now, while the module is neither
  # enforcing nor decommissioning.
  stranded = local.security_defaults_prior && local.security_defaults_now == false && !var.enforce && !var.decommission

  turn_off = var.enforce && !var.decommission && local.security_defaults_prior
  restore  = var.decommission && local.security_defaults_prior
}

# Security defaults are read at plan time. The read depends on no input or licence data.
data "msgraph_resource" "security_defaults" {
  url         = "policies/identitySecurityDefaultsEnforcementPolicy"
  api_version = "v1.0"

  response_export_values = {
    is_enabled = "isEnabled"
  }

  lifecycle {
    postcondition {
      condition     = try(self.output.is_enabled == tobool(self.output.is_enabled), false)
      error_message = "The security defaults response is malformed: isEnabled is not a boolean."
    }
  }
}

# The existing policies, read only for the enforce precondition. Graph is read without a
# $filter and filtered here on the display names, so no filter operator is relied on.
data "msgraph_resource" "existing_policies" {
  count = var.enforce && !var.decommission ? 1 : 0

  url         = local.policies_url
  api_version = "v1.0"

  response_export_values = {
    policies  = "value[].{id: id, displayName: displayName}"
    next_link = "\"@odata.nextLink\""
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.policies != null && can(concat(self.output.policies, [])) &&
        contains(keys(self.output), "next_link") && self.output.next_link == null &&
        alltrue([for policy in self.output.policies : policy.displayName != null && policy.displayName == tostring(policy.displayName)]),
        false
      )
      error_message = "The Conditional Access policy list is malformed, incomplete or still paginated; the baseline's existence cannot be confirmed."
    }
  }
}

# The first value stays, so the recorded prior state survives later applies, including the
# applies that turn security defaults off.
resource "terraform_data" "security_defaults_prior" {
  input = local.security_defaults_now

  lifecycle {
    ignore_changes = [input]
  }
}

# The mode of the first apply is recorded and never overwritten, so that an enforce on a fresh
# state is refused even when policies with the baseline names already exist (lost state, a second
# instance with the same prefix, or hand-made placeholders).
resource "terraform_data" "first_apply_mode" {
  input = var.enforce

  lifecycle {
    ignore_changes = [input]
  }
}

# Plan-time guard for the cross-input rules.
resource "terraform_data" "guard" {
  input = {
    tier = var.decommission ? var.tier : module.licence_guard[0].tier
  }

  lifecycle {
    precondition {
      condition     = !(var.enforce && var.decommission)
      error_message = "enforce and decommission cannot both be true. Decommission deletes the policies; set enforce = false for that apply."
    }

    precondition {
      condition     = !var.enforce || var.decommission || length(local.missing_names) == 0
      error_message = "enforce = true needs the four baseline policies to exist already, so that the first apply is report-only. Missing: ${join(", ", local.missing_names)}. Apply with enforce = false first, review the sign-in logs, then enforce."
    }

    precondition {
      condition     = terraform_data.first_apply_mode.input != true
      error_message = "The first apply of this module's state must be report-only. Apply with enforce = false, so the exclusions are read back before anything is enforced, then set enforce = true."
    }

    precondition {
      condition     = !local.stranded
      error_message = "Security defaults were on before this module and are off now, and enforce is false. Applying would leave the tenant with report-only policies and no security defaults. Keep enforce = true, or set decommission = true to delete the policies and restore security defaults."
    }
  }
}

# Turns security defaults off, only in an enforce apply and only when they were on. The policies
# depend on this resource, so security defaults are off before any policy becomes enabled.
# Deleting an msgraph_update_resource sends no request: see the README for the destroy order.
resource "msgraph_update_resource" "security_defaults_off" {
  count = local.turn_off ? 1 : 0

  url           = "policies/identitySecurityDefaultsEnforcementPolicy"
  api_version   = "v1.0"
  update_method = "PATCH"
  body          = { isEnabled = false }

  depends_on = [terraform_data.guard, terraform_data.security_defaults_prior, module.emergency_access]
}

resource "msgraph_resource" "policy" {
  for_each = toset(local.policy_keys)

  url                     = local.policies_url
  api_version             = "v1.0"
  body                    = local.bodies[each.key]
  ignore_missing_property = false

  response_export_values = {
    id            = "id"
    state         = "state"
    exclude_users = "conditions.users.excludeUsers"
  }

  depends_on = [terraform_data.guard, msgraph_update_resource.security_defaults_off]

  lifecycle {
    # The break-glass exclusion is read back from Graph, not assumed from the request.
    postcondition {
      condition = nonsensitive(sensitive(try(
        alltrue([for id in local.exclude_users : contains(self.output.exclude_users, id)]) && length(local.exclude_users) > 0,
        false
      )))
      error_message = "A break-glass user is missing from conditions.users.excludeUsers of policy ${each.key} as Graph returned it. Do not enforce this baseline."
    }
  }
}

# Sets security defaults back to the recorded value, after the policies are deleted. Learn says
# security defaults cannot be turned on while Conditional Access policies exist.
resource "msgraph_update_resource" "security_defaults_restore" {
  count = local.restore ? 1 : 0

  url           = "policies/identitySecurityDefaultsEnforcementPolicy"
  api_version   = "v1.0"
  update_method = "PATCH"
  body          = { isEnabled = true }

  depends_on = [msgraph_resource.policy, terraform_data.security_defaults_prior]
}

# Warnings only.
check "two_emergency_access_accounts" {
  assert {
    condition     = var.decommission || nonsensitive(sensitive(length(local.exclude_users) >= 2))
    error_message = "Fewer than two emergency access accounts are excluded. Microsoft recommends two or more, so that the loss of one does not lock the tenant."
  }
}
