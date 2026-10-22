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

# Restoring before any apply: the snapshot is taken from the current tenant, so the restore body equals the current values.
run "restore_on_the_first_apply" {
  command = apply

  variables {
    tier                 = "free"
    restore_prior_values = true
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
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "A restore on the first apply must send the current values back unchanged."
  }

  assert {
    condition     = length(output.planned_changes) == 0
    error_message = "A restore on the first apply changes nothing."
  }
}
