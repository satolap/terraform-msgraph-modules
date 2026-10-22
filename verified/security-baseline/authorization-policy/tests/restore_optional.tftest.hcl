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

# Only properties the module set are restored. The app input is set; the tenant input is null.
run "apply_with_apps_false" {
  command = apply

  variables {
    tier                       = "free"
    allow_users_to_create_apps = false
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
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"allowedToCreateApps\":false,\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "The app input must be sent and the null tenant input left out."
  }
}

# allowedToCreateApps is restored because the module set it; allowedToCreateTenants is neither restored nor compared, even
# though an administrator changed it after the apply.
run "restore_covers_only_the_properties_the_module_set" {
  command = plan

  variables {
    tier                       = "free"
    allow_users_to_create_apps = false
    restore_prior_values       = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = false
        allowed_to_create_tenants         = false
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"allowedToCreateApps\":true,\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "The restore must hold the optional property the module set and leave the other alone."
  }
}

# The inputs changed since the apply (guest_access), so the tenant no longer matches what they would apply: the restore refuses.
run "restore_refuses_when_inputs_changed_since_the_apply" {
  command = plan

  variables {
    tier                       = "free"
    allow_users_to_create_apps = false
    guest_access               = "limited"
    restore_prior_values       = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = false
        allowed_to_create_tenants         = true
      }
    }
  }

  expect_failures = [terraform_data.gate]
}

run "restore_with_changed_inputs_can_be_forced" {
  command = plan

  variables {
    tier                       = "free"
    allow_users_to_create_apps = false
    guest_access               = "limited"
    restore_prior_values       = true
    restore_over_changes       = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = false
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"allowedToCreateApps\":true,\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "restore_over_changes must restore the snapshot."
  }
}
