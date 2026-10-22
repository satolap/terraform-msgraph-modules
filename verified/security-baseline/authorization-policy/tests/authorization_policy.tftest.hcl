# Fixtures follow the Microsoft Graph responses for GET /policies/authorizationPolicy and
# GET /policies/permissionGrantPolicies (selecting id). Property values are the documented
# ones; no tenant identities are recorded.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
        policies                          = [{ id = "microsoft-user-default-low" }, { id = "microsoft-user-default-recommended" }, { id = "microsoft-user-default-legacy" }]
        next_link                         = null
      }
    }
  }
}

# Test 1: the defaults send exactly the managed keys. The kept owned-resource entry comes first, then the
# low self-consent entry; the optional app and tenant inputs are null and absent.
run "defaults" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "The default body must hold exactly the managed keys, the kept entry and the low self-consent entry."
  }

  assert {
    condition     = msgraph_update_resource.policy.url == "policies/authorizationPolicy" && msgraph_update_resource.policy.api_version == "v1.0" && msgraph_update_resource.policy.update_method == "PATCH"
    error_message = "The singleton must be updated with PATCH on the v1.0 path."
  }

  assert {
    condition     = data.msgraph_resource.policy.url == "policies/authorizationPolicy" && data.msgraph_resource.policy.api_version == "v1.0"
    error_message = "The current values must be read from the v1.0 authorizationPolicy."
  }

  assert {
    condition     = data.msgraph_resource.consent_policies[0].url == "policies/permissionGrantPolicies" && data.msgraph_resource.consent_policies[0].api_version == "v1.0"
    error_message = "The consent policy must be looked up in the v1.0 permission grant policies."
  }

  assert {
    condition     = output.tier == "free"
    error_message = "The tier output must pass the tier through."
  }
}

# Test 2: a mixed-case self-consent entry is replaced whatever its case, and owned-resource entries are kept.
run "existing_entries_replaced_case_insensitively" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForSelf.microsoft-user-default-legacy", "ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managepermissiongrantsforself.some-other-policy", "ManagePermissionGrantsForOwnedResource.Other"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"ManagePermissionGrantsForOwnedResource.Other\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "Self entries of any case must be replaced and the owned-resource entries kept."
  }
}

# Test 3: a null consent policy disables user consent: no self entry, owned-resource entries kept, and no policy lookup.
run "consent_disabled" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = null
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForSelf.microsoft-user-default-legacy", "ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "Disabling consent must keep only the non-self entries."
  }

  assert {
    condition     = length(data.msgraph_resource.consent_policies) == 0
    error_message = "No consent policy is looked up when consent is disabled."
  }
}

run "consent_disabled_without_other_entries" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = null
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForSelf.microsoft-user-default-legacy"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "With nothing left, the consent list must be sent empty to disable user consent."
  }
}

# Test 4: optional inputs. Null leaves the key out of the body; false and true send it.
run "optional_inputs_false" {
  command = plan

  variables {
    tier                          = "free"
    allow_users_to_create_apps    = false
    allow_users_to_create_tenants = false
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"allowedToCreateApps\":false,\"allowedToCreateTenants\":false,\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "false must be sent for both optional inputs."
  }
}

run "optional_inputs_true_and_null_mix" {
  command = plan

  variables {
    tier                       = "free"
    allow_users_to_create_apps = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = false
        allowed_to_create_tenants         = false
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"allowedToCreateApps\":true,\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "true must be sent for the app input and the null tenant input must be absent."
  }

  assert {
    condition     = !contains(keys(msgraph_update_resource.policy.body.defaultUserRolePermissions), "allowedToCreateTenants")
    error_message = "A null tenant input must leave allowedToCreateTenants out of the body."
  }
}

run "optional_inputs_null_are_absent" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = false
        allowed_to_create_tenants         = false
      }
    }
  }

  assert {
    condition     = !contains(keys(msgraph_update_resource.policy.body.defaultUserRolePermissions), "allowedToCreateApps") && !contains(keys(msgraph_update_resource.policy.body.defaultUserRolePermissions), "allowedToCreateTenants")
    error_message = "Null optional inputs must leave their keys out of the body."
  }
}

# Inputs map to documented values: limited guest access and every allowInvitesFrom value.
run "limited_guest_access_and_none_invites" {
  command = plan

  variables {
    tier               = "free"
    guest_access       = "limited"
    allow_invites_from = "none"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"none\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"10dae51f-b6af-4016-8d66-8c2a99b929b3\"}"
    error_message = "limited must set the Guest User role and none must be sent as given."
  }
}

run "invites_adminsGuestInvitersAndAllMembers" {
  command = plan

  variables {
    tier               = "free"
    allow_invites_from = "adminsGuestInvitersAndAllMembers"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = msgraph_update_resource.policy.body.allowInvitesFrom == "adminsGuestInvitersAndAllMembers"
    error_message = "adminsGuestInvitersAndAllMembers must be accepted and sent."
  }
}

run "invites_everyone" {
  command = plan

  variables {
    tier               = "free"
    allow_invites_from = "everyone"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = msgraph_update_resource.policy.body.allowInvitesFrom == "everyone"
    error_message = "everyone must be accepted and sent."
  }
}

run "recommended_consent_policy_is_allowed" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "microsoft-user-default-recommended"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = contains(msgraph_update_resource.policy.body.defaultUserRolePermissions.permissionGrantPoliciesAssigned, "managePermissionGrantsForSelf.microsoft-user-default-recommended")
    error_message = "The Microsoft-managed recommended policy must be accepted."
  }
}

# Test 7: no planned body holds an unmanaged key, such as allowedToReadOtherUsers, whatever the inputs.
run "no_unmanaged_keys" {
  command = plan

  variables {
    tier                          = "free"
    allow_users_to_create_apps    = false
    allow_users_to_create_tenants = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = alltrue([for key in keys(msgraph_update_resource.policy.body) : contains(["allowInvitesFrom", "allowUserConsentForRiskyApps", "defaultUserRolePermissions", "guestUserRoleId"], key)])
    error_message = "Only managed top-level keys may be sent."
  }

  assert {
    condition     = alltrue([for key in keys(msgraph_update_resource.policy.body.defaultUserRolePermissions) : contains(["allowedToCreateApps", "allowedToCreateTenants", "permissionGrantPoliciesAssigned"], key)])
    error_message = "Only managed defaultUserRolePermissions keys may be sent."
  }

  assert {
    condition     = !strcontains(jsonencode(msgraph_update_resource.policy.body), "allowedToReadOtherUsers") && !strcontains(jsonencode(msgraph_update_resource.policy.body), "blockMsolPowerShell") && !strcontains(jsonencode(msgraph_update_resource.policy.body), "allowedToUseSSPR")
    error_message = "allowedToReadOtherUsers and the other unmanaged properties must never be sent."
  }
}

# planned_changes lists each property whose current value differs from the target, with both values.
run "planned_changes_show_each_change" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = length(output.planned_changes) == 0
    error_message = "A tenant that already holds the target values has no planned change."
  }
}

run "planned_changes_for_a_default_tenant" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = true
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = [for change in output.planned_changes : change.property] == ["allowInvitesFrom", "allowUserConsentForRiskyApps", "defaultUserRolePermissions.permissionGrantPoliciesAssigned", "guestUserRoleId"]
    error_message = "Every differing managed property must be listed."
  }

  assert {
    condition     = [for change in output.planned_changes : change.current if change.property == "allowInvitesFrom"] == ["\"everyone\""] && [for change in output.planned_changes : change.target if change.property == "allowInvitesFrom"] == ["\"adminsAndGuestInviters\""]
    error_message = "Each change must show the current and the target value."
  }

  assert {
    condition     = output.target_values.allowInvitesFrom == "adminsAndGuestInviters" && jsonencode(output.target_values["defaultUserRolePermissions.permissionGrantPoliciesAssigned"]) == jsonencode(["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"])
    error_message = "target_values must show what the module sets."
  }
}

# Test 8: the free tier plans no subscribedSkus read. The override is a response that would fail the licence
# guard's postcondition, so a planned read would fail this run.
run "free_plans_no_licence_read" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus
    values = {
      output = {
        skus      = null
        next_link = "https://graph.microsoft.com/v1.0/subscribedSkus?$skiptoken=synthetic"
      }
    }
  }

  assert {
    condition     = output.tier == "free" && length(module.licence_guard.licensed_skus) == 0
    error_message = "The free tier must pass without reading licences."
  }
}

# p1 and p2 run the shared licence guard. An Enabled SKU with enabled units passes; the tier changes no setting.
run "p1_with_licensed_sku_passes" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans     = [{ servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" }]
          },
        ]
      }
    }
  }

  assert {
    condition     = output.tier == "p1" && [for entry in module.licence_guard.licensed_skus : entry.sku_part_number] == ["AAD_PREMIUM"]
    error_message = "An Enabled P1 SKU must license p1."
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "The tier must change no setting."
  }
}

run "p2_with_licensed_sku_passes" {
  command = plan

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans     = [{ servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" }]
          },
        ]
      }
    }
  }

  assert {
    condition     = output.tier == "p2"
    error_message = "An Enabled P2 SKU must license p2."
  }
}

# Tests 9 to 13: invalid inputs fail validation with a message that names the value.
run "rejects_legacy_consent_policy" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "microsoft-user-default-legacy"
  }

  expect_failures = [var.user_consent_policy_id]
}

run "rejects_legacy_consent_policy_in_any_case" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "Microsoft-User-Default-Legacy"
  }

  expect_failures = [var.user_consent_policy_id]
}

run "rejects_prefixed_consent_policy" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "managePermissionGrantsForSelf.microsoft-user-default-low"
  }

  expect_failures = [var.user_consent_policy_id]
}

run "rejects_lowercase_prefixed_consent_policy" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "managepermissiongrantsforself.microsoft-user-default-low"
  }

  expect_failures = [var.user_consent_policy_id]
}

run "rejects_malformed_consent_policy_id" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "a b,c"
  }

  expect_failures = [var.user_consent_policy_id]
}

run "rejects_empty_consent_policy_id" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = ""
  }

  expect_failures = [var.user_consent_policy_id]
}

run "rejects_unknown_invites_value" {
  command = plan

  variables {
    tier               = "free"
    allow_invites_from = "members"
  }

  expect_failures = [var.allow_invites_from]
}

run "rejects_invites_value_case_mismatch" {
  command = plan

  variables {
    tier               = "free"
    allow_invites_from = "Everyone"
  }

  expect_failures = [var.allow_invites_from]
}

run "rejects_member_guest_access" {
  command = plan

  variables {
    tier         = "free"
    guest_access = "member"
  }

  expect_failures = [var.guest_access]
}

run "rejects_raw_guid_guest_access" {
  command = plan

  variables {
    tier         = "free"
    guest_access = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
  }

  expect_failures = [var.guest_access]
}

run "rejects_unknown_tier" {
  command = plan

  variables {
    tier = "auto"
  }

  expect_failures = [var.tier]
}

# Test 11: a consent policy that the tenant does not list fails a precondition that names the ID.
run "rejects_missing_consent_policy" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "custom-consent-policy"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  expect_failures = [terraform_data.gate]
}

run "accepts_existing_custom_consent_policy" {
  command = plan

  variables {
    tier                   = "free"
    user_consent_policy_id = "custom-consent-policy"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  override_data {
    target = data.msgraph_resource.consent_policies[0]
    values = {
      output = {
        policies  = [{ id = "microsoft-user-default-low" }, { id = "custom-consent-policy" }]
        next_link = null
      }
    }
  }

  assert {
    condition     = contains(msgraph_update_resource.policy.body.defaultUserRolePermissions.permissionGrantPoliciesAssigned, "managePermissionGrantsForSelf.custom-consent-policy")
    error_message = "An existing custom policy must be accepted."
  }
}

# A response without the consent list fails the plan instead of reading as empty.
run "rejects_missing_consent_list" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = null
        permission_grant_policies         = null
        allowed_to_create_apps            = null
        allowed_to_create_tenants         = null
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "empty_consent_list_is_accepted" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "everyone"
        guest_user_role_id                = "a0b1b346-4d3e-4e8b-98f8-753987be4970"
        allow_user_consent_for_risky_apps = null
        permission_grant_policies         = []
        allowed_to_create_apps            = null
        allowed_to_create_tenants         = null
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "An empty list and null booleans must plan the baseline."
  }
}

# An existing self entry for the chosen policy keeps its Graph spelling and position, so the plan is a no-op.
run "graph_cased_self_entry_keeps_spelling_and_position" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForSelf.microsoft-user-default-low", "ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForSelf.microsoft-user-default-low\",\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "The existing entry must keep its spelling and its first position."
  }

  assert {
    condition     = length(output.planned_changes) == 0
    error_message = "A tenant that already holds the target in Graph's casing plans no change."
  }
}
