# Positive cases. Fixtures follow the Microsoft Graph responses for the selected properties:
# - List users and subscribedSkus as in the emergency access guard tests;
# - Get identitySecurityDefaultsEnforcementPolicy: isEnabled;
# - List conditionalAccessPolicies: id and displayName;
# - Create conditionalAccessPolicy: the read-back carries id, state and conditions.users.
# IDs are deliberately synthetic; no tenant identities are recorded.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link  = null
        is_enabled = true
        policies   = []
        groups     = []
        members    = []
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  mock_resource "msgraph_resource" {
    defaults = {
      output = {
        id             = "00000000-0000-4000-8000-0000000000f0"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
        exclude_groups = []
      }
    }
  }
}

variables {
  tier                 = "p1"
  break_glass_user_ids = ["00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000010"]
}

# 1. Defaults: four policies on the Conditional Access collection, report-only, and no
# security defaults resources.
run "defaults_are_report_only" {
  command = plan

  assert {
    condition     = sort(keys(msgraph_resource.policy)) == tolist(["admins", "all_users", "azure_management", "legacy_auth"])
    error_message = "Exactly the four baseline policies are declared."
  }

  assert {
    condition     = alltrue([for policy in msgraph_resource.policy : policy.url == "identity/conditionalAccess/policies" && policy.api_version == "v1.0" && policy.body.state == "enabledForReportingButNotEnforced"])
    error_message = "Every policy posts to identity/conditionalAccess/policies (v1.0) in report-only state."
  }

  assert {
    condition     = length(msgraph_update_resource.security_defaults_off) == 0 && length(msgraph_update_resource.security_defaults_restore) == 0
    error_message = "Report-only never touches security defaults."
  }

  assert {
    condition     = length(data.msgraph_resource.existing_policies) == 0
    error_message = "The existing policies are read only to enforce."
  }

  assert {
    condition     = msgraph_resource.policy["admins"].body.displayName == "Security baseline - Require multifactor authentication for admins" && msgraph_resource.policy["legacy_auth"].body.displayName == "Security baseline - Block legacy authentication" && msgraph_resource.policy["all_users"].body.displayName == "Security baseline - Require multifactor authentication for all users" && msgraph_resource.policy["azure_management"].body.displayName == "Security baseline - Require multifactor authentication for Azure management"
    error_message = "Display names use the default prefix."
  }

  assert {
    condition     = module.licence_guard[0].licensed_skus[0].sku_part_number == "AAD_PREMIUM" && output.tier == "p1"
    error_message = "The licence guard ran for tier p1 and exposes the licensing SKU."
  }

  assert {
    condition     = length(data.msgraph_resource.security_defaults.url) > 0 && data.msgraph_resource.security_defaults.url == "policies/identitySecurityDefaultsEnforcementPolicy"
    error_message = "Security defaults are read from the singleton."
  }
}

# 2. Bodies match the issue's table.
run "bodies_match_the_design" {
  command = plan

  assert {
    condition     = length(msgraph_resource.policy["admins"].body.conditions.users.includeRoles) == 16 && contains(msgraph_resource.policy["admins"].body.conditions.users.includeRoles, "62e90394-69f5-4237-9190-012177145e10") && contains(msgraph_resource.policy["admins"].body.conditions.users.includeRoles, "0526716b-113d-4c15-b2c8-68e3c22b9f80") && contains(msgraph_resource.policy["admins"].body.conditions.users.includeRoles, "45d8d3c5-c802-45c6-b32a-1d70b5e1e86e")
    error_message = "The administrator policy targets the 16 default role template IDs."
  }

  assert {
    condition     = length(msgraph_resource.policy["admins"].body.conditions.users.includeUsers) == 0 && tolist(msgraph_resource.policy["admins"].body.conditions.applications.includeApplications) == tolist(["All"]) && tolist(msgraph_resource.policy["admins"].body.conditions.clientAppTypes) == tolist(["all"]) && tolist(msgraph_resource.policy["admins"].body.grantControls.builtInControls) == tolist(["mfa"]) && msgraph_resource.policy["admins"].body.grantControls.operator == "OR"
    error_message = "The administrator policy requires MFA for all applications and client types."
  }

  assert {
    condition     = tolist(msgraph_resource.policy["legacy_auth"].body.conditions.users.includeUsers) == tolist(["All"]) && tolist(msgraph_resource.policy["legacy_auth"].body.conditions.clientAppTypes) == tolist(["exchangeActiveSync", "other"]) && tolist(msgraph_resource.policy["legacy_auth"].body.grantControls.builtInControls) == tolist(["block"]) && tolist(msgraph_resource.policy["legacy_auth"].body.conditions.applications.includeApplications) == tolist(["All"])
    error_message = "The legacy authentication policy blocks the legacy client app types."
  }

  assert {
    condition     = tolist(msgraph_resource.policy["all_users"].body.conditions.users.includeUsers) == tolist(["All"]) && tolist(msgraph_resource.policy["all_users"].body.conditions.users.excludeRoles) == tolist(["d29b2b05-8046-44ba-8758-1e26182fcf32"]) && tolist(msgraph_resource.policy["all_users"].body.grantControls.builtInControls) == tolist(["mfa"]) && tolist(msgraph_resource.policy["all_users"].body.conditions.clientAppTypes) == tolist(["all"])
    error_message = "The all-users policy excludes the Directory Synchronization Accounts role by default."
  }

  assert {
    condition     = tolist(msgraph_resource.policy["azure_management"].body.conditions.applications.includeApplications) == tolist(["797f4846-ba00-4fd7-ba43-dac1f8f63013"]) && tolist(msgraph_resource.policy["azure_management"].body.conditions.users.includeUsers) == tolist(["All"]) && tolist(msgraph_resource.policy["azure_management"].body.grantControls.builtInControls) == tolist(["mfa"])
    error_message = "The Azure management policy targets the Windows Azure Service Management API."
  }

  assert {
    condition     = alltrue([for key in ["admins", "legacy_auth", "azure_management"] : length(msgraph_resource.policy[key].body.conditions.users.excludeRoles) == 0])
    error_message = "Only the all-users policy excludes a role."
  }
}

run "directory_sync_exclusion_can_be_switched_off" {
  command = plan

  variables {
    exclude_directory_sync_accounts = false
  }

  assert {
    condition     = length(msgraph_resource.policy["all_users"].body.conditions.users.excludeRoles) == 0
    error_message = "exclude_directory_sync_accounts = false removes the role exclusion."
  }
}

run "additional_admin_roles_are_added_lowercased_and_deduplicated" {
  command = plan

  variables {
    additional_admin_role_template_ids = ["00000000-0000-4000-8000-0000000000B1", "62E90394-69F5-4237-9190-012177145E10"]
  }

  assert {
    condition     = length(msgraph_resource.policy["admins"].body.conditions.users.includeRoles) == 17 && contains(msgraph_resource.policy["admins"].body.conditions.users.includeRoles, "00000000-0000-4000-8000-0000000000b1")
    error_message = "An additional role is added in lowercase and a default role is not duplicated."
  }

  assert {
    condition     = length(msgraph_resource.policy["all_users"].body.conditions.users.includeRoles) == 0
    error_message = "Additional roles apply to the administrator policy only."
  }
}

run "display_name_prefix_is_used" {
  command = plan

  variables {
    display_name_prefix = "Contoso - "
  }

  assert {
    condition     = msgraph_resource.policy["legacy_auth"].body.displayName == "Contoso - Block legacy authentication" && msgraph_resource.policy["admins"].body.displayName == "Contoso - Require multifactor authentication for admins"
    error_message = "The prefix is prepended to the policy names."
  }
}

# 3. The break-glass users are excluded from all four policies, and read back.
run "break_glass_users_are_excluded_everywhere" {
  command = apply

  assert {
    condition     = alltrue([for policy in msgraph_resource.policy : policy.body.conditions.users.excludeUsers == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"])])
    error_message = "Every policy excludes the sorted break-glass users."
  }

  assert {
    condition     = alltrue([for policy in msgraph_resource.policy : length(policy.body.conditions.users.excludeGroups) == 0])
    error_message = "No group is sent as an exclusion."
  }

  assert {
    condition     = jsonencode(output.policy_states) == jsonencode({ admins = "enabledForReportingButNotEnforced", all_users = "enabledForReportingButNotEnforced", azure_management = "enabledForReportingButNotEnforced", legacy_auth = "enabledForReportingButNotEnforced" })
    error_message = "The read-back states are exported."
  }

  assert {
    condition     = length(output.policy_ids) == 4 && output.security_defaults_prior_enabled == true && output.security_defaults_turned_off_by_module == false
    error_message = "Policy IDs are exported and security defaults are untouched."
  }
}

# A break-glass group is validated and its user members are snapshotted into excludeUsers; the
# group ID itself is never an exclusion.
run "break_glass_group_members_are_snapshotted_as_users" {
  command = plan

  variables {
    break_glass_user_ids  = ["00000000-0000-4000-8000-000000000010"]
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = module.emergency_access[0].data.msgraph_resource.groups[0]
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = true },
        ]
      }
    }
  }

  override_data {
    target = module.emergency_access[0].data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000020" },
        ]
      }
    }
  }

  assert {
    condition     = alltrue([for policy in msgraph_resource.policy : policy.body.conditions.users.excludeUsers == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]) && length(policy.body.conditions.users.excludeGroups) == 0])
    error_message = "The group's user member is excluded as a user; the group is not."
  }
}

# 4. enforce = true with the baseline existing and security defaults on: enabled, and security
# defaults are turned off first.
run "enforce_turns_security_defaults_off_and_enables" {
  command = plan

  variables {
    enforce = true
  }

  override_data {
    target = data.msgraph_resource.existing_policies[0]
    values = {
      output = {
        next_link = null
        policies = [
          { id = "00000000-0000-4000-8000-0000000000a1", displayName = "Security baseline - Require multifactor authentication for admins" },
          { id = "00000000-0000-4000-8000-0000000000a2", displayName = "Security baseline - Block legacy authentication" },
          { id = "00000000-0000-4000-8000-0000000000a3", displayName = "Security baseline - Require multifactor authentication for all users" },
          { id = "00000000-0000-4000-8000-0000000000a4", displayName = "Security baseline - Require multifactor authentication for Azure management" },
          { id = "00000000-0000-4000-8000-0000000000a5", displayName = "Unrelated policy" },
        ]
      }
    }
  }

  assert {
    condition     = alltrue([for policy in msgraph_resource.policy : policy.body.state == "enabled"])
    error_message = "enforce = true sets every policy to enabled."
  }

  assert {
    condition     = length(msgraph_update_resource.security_defaults_off) == 1 && msgraph_update_resource.security_defaults_off[0].body == { isEnabled = false } && msgraph_update_resource.security_defaults_off[0].url == "policies/identitySecurityDefaultsEnforcementPolicy" && msgraph_update_resource.security_defaults_off[0].update_method == "PATCH"
    error_message = "Security defaults are turned off with isEnabled = false when they were on."
  }

  assert {
    condition     = length(msgraph_update_resource.security_defaults_restore) == 0
    error_message = "Enforce restores nothing."
  }
}

# The policies depend on the security defaults write, so security defaults go off first.
run "enforce_orders_security_defaults_before_policies" {
  command = plan

  variables {
    enforce = true
  }

  override_data {
    target = data.msgraph_resource.existing_policies[0]
    values = {
      output = {
        next_link = null
        policies = [
          { id = "00000000-0000-4000-8000-0000000000a1", displayName = "Security baseline - Require multifactor authentication for admins" },
          { id = "00000000-0000-4000-8000-0000000000a2", displayName = "Security baseline - Block legacy authentication" },
          { id = "00000000-0000-4000-8000-0000000000a3", displayName = "Security baseline - Require multifactor authentication for all users" },
          { id = "00000000-0000-4000-8000-0000000000a4", displayName = "Security baseline - Require multifactor authentication for Azure management" },
        ]
      }
    }
  }

  assert {
    condition     = output.security_defaults_turned_off_by_module == true
    error_message = "The module reports that it turns security defaults off."
  }
}

# 6. decommission = true with prior state true: no policies, restore with isEnabled = true.
run "decommission_restores_security_defaults" {
  command = plan

  variables {
    decommission = true
  }

  assert {
    condition     = length(msgraph_resource.policy) == 0
    error_message = "A decommission apply declares no policy."
  }

  assert {
    condition     = length(msgraph_update_resource.security_defaults_restore) == 1 && msgraph_update_resource.security_defaults_restore[0].body == { isEnabled = true } && msgraph_update_resource.security_defaults_restore[0].url == "policies/identitySecurityDefaultsEnforcementPolicy"
    error_message = "Security defaults are restored when they were on before the module."
  }

  assert {
    condition     = length(module.licence_guard) == 0 && length(module.emergency_access) == 0 && length(msgraph_update_resource.security_defaults_off) == 0
    error_message = "A decommission apply checks neither licences nor break-glass accounts, and turns nothing off."
  }

  assert {
    condition     = output.tier == "p1" && length(output.licensed_skus) == 0 && length(output.policy_ids) == 0
    error_message = "The outputs are empty or defaulted during a decommission."
  }
}

# 7. Sticky prior state: run 1 sees security defaults on, run 2 sees them off after the module
# enforced, and the recorded prior value stays true; run 3 decommissions and restores them.
run "sticky_prior_state_is_recorded_as_on" {
  command = apply

  assert {
    condition     = output.security_defaults_prior_enabled == true
    error_message = "The first apply records security defaults as on."
  }
}

run "sticky_enforce_after_security_defaults_turned_off" {
  command = apply

  variables {
    enforce = true
  }

  override_data {
    target = data.msgraph_resource.security_defaults
    values = {
      output = { is_enabled = false }
    }
  }

  override_data {
    target = data.msgraph_resource.existing_policies[0]
    values = {
      output = {
        next_link = null
        policies = [
          { id = "00000000-0000-4000-8000-0000000000a1", displayName = "Security baseline - Require multifactor authentication for admins" },
          { id = "00000000-0000-4000-8000-0000000000a2", displayName = "Security baseline - Block legacy authentication" },
          { id = "00000000-0000-4000-8000-0000000000a3", displayName = "Security baseline - Require multifactor authentication for all users" },
          { id = "00000000-0000-4000-8000-0000000000a4", displayName = "Security baseline - Require multifactor authentication for Azure management" },
        ]
      }
    }
  }

  assert {
    condition     = output.security_defaults_prior_enabled == true
    error_message = "The recorded prior state stays true although security defaults now read as off."
  }

  assert {
    condition     = length(msgraph_update_resource.security_defaults_off) == 1
    error_message = "The enforce apply still turns security defaults off, from the sticky prior state."
  }
}

run "sticky_decommission_restores_from_recorded_state" {
  command = apply

  variables {
    decommission = true
  }

  override_data {
    target = data.msgraph_resource.security_defaults
    values = {
      output = { is_enabled = false }
    }
  }

  assert {
    condition     = length(msgraph_update_resource.security_defaults_restore) == 1 && length(msgraph_resource.policy) == 0
    error_message = "Decommission restores security defaults although they read as off, because they were on before the module."
  }
}

# 8. Licence: a tenant with only P2 passes tier p1 (the P2 product also lists AAD_PREMIUM), and
# P1 plus P2 passes tier p2.
run "p2_only_tenant_passes_p1" {
  command = plan

  override_data {
    target = module.licence_guard[0].data.msgraph_resource.subscribed_skus[0]
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000002"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = output.tier == "p1" && module.licence_guard[0].licensed_skus[0].sku_part_number == "AAD_PREMIUM_P2"
    error_message = "A P2-only tenant satisfies tier p1."
  }
}

run "p1_and_p2_tenant_passes_p2" {
  command = plan

  variables {
    tier = "p2"
  }

  # The emergency access guard runs its own licence guard for the same tier.
  override_data {
    target = module.emergency_access[0].module.licence_guard.data.msgraph_resource.subscribed_skus[0]
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000002"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  override_data {
    target = module.licence_guard[0].data.msgraph_resource.subscribed_skus[0]
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
          {
            skuId            = "00000000-0000-4000-8000-000000000002"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = output.tier == "p2" && length(module.licence_guard[0].licensed_skus) == 1 && module.licence_guard[0].licensed_skus[0].sku_part_number == "AAD_PREMIUM_P2"
    error_message = "P2 is licensed by the SKU that lists the P2 plan."
  }
}
