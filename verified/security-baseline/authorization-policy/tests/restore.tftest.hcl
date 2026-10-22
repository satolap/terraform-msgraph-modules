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

# Tests 5 and 6: the snapshot, then a restore. The baseline tenant has a null allowUserConsentForRiskyApps, as in the
# Learn GET example, and a legacy self-consent entry in Graph's casing.
run "apply_baseline" {
  command = apply

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
        permission_grant_policies         = ["ManagePermissionGrantsForSelf.microsoft-user-default-legacy", "ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = output.prior_values["allowInvitesFrom"] == "everyone" && output.prior_values["allowUserConsentForRiskyApps"] == null
    error_message = "The snapshot must capture the values read before the first apply, including null."
  }

  assert {
    condition     = output.prior_values["guestUserRoleId"] == "a0b1b346-4d3e-4e8b-98f8-753987be4970" && jsonencode(output.prior_values["defaultUserRolePermissions.permissionGrantPoliciesAssigned"]) == jsonencode(["ManagePermissionGrantsForSelf.microsoft-user-default-legacy", "ManagePermissionGrantsForOwnedResource.DeveloperConsent"])
    error_message = "The snapshot must hold the guest role and the full consent list."
  }
}

# Test 6: on later plans the tenant holds the baseline values, and the snapshot does not change.
run "snapshot_is_kept_on_a_later_plan" {
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
    condition     = output.prior_values["allowInvitesFrom"] == "everyone" && output.prior_values["guestUserRoleId"] == "a0b1b346-4d3e-4e8b-98f8-753987be4970"
    error_message = "The snapshot must keep the original values."
  }

  assert {
    condition     = length(output.planned_changes) == 0
    error_message = "A second plan with unchanged inputs must plan no change."
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"adminsAndGuestInviters\",\"allowUserConsentForRiskyApps\":false,\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"managePermissionGrantsForSelf.microsoft-user-default-low\"]},\"guestUserRoleId\":\"2af84b1e-32c8-42b7-82bc-daa82404023b\"}"
    error_message = "The body must stay the baseline."
  }
}

# Test 5: restore PATCHes the snapshot; null snapshot values are omitted.
run "restore_sends_the_snapshot" {
  command = apply

  variables {
    tier                 = "free"
    restore_prior_values = true
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
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"ManagePermissionGrantsForSelf.microsoft-user-default-legacy\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "The restore body must equal the snapshot, without the null property."
  }

  assert {
    condition     = !contains(keys(msgraph_update_resource.policy.body), "allowUserConsentForRiskyApps")
    error_message = "A null snapshot value must not be sent."
  }

  assert {
    condition     = jsonencode(output.target_values) == jsonencode(output.prior_values) || !contains(keys(output.target_values), "allowUserConsentForRiskyApps")
    error_message = "target_values must show the restore."
  }
}

# After the restore is applied, the tenant holds the snapshot values; planning the restore again passes.
run "restore_again_after_restore_is_a_no_op" {
  command = plan

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
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "ManagePermissionGrantsForSelf.microsoft-user-default-legacy"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"ManagePermissionGrantsForSelf.microsoft-user-default-legacy\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "The body must stay the snapshot."
  }

  assert {
    condition     = length(output.planned_changes) == 0
    error_message = "A restored tenant has no planned change."
  }
}

# A reorder or respell that the PATCH will send is shown in planned_changes when restoring.
run "restore_shows_a_reorder_in_planned_changes" {
  command = plan

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
        permission_grant_policies         = ["ManagePermissionGrantsForSelf.microsoft-user-default-legacy", "ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = [for change in output.planned_changes : change.property] == ["defaultUserRolePermissions.permissionGrantPoliciesAssigned"]
    error_message = "The restore reorders the consent list, so the change must be listed."
  }
}

# The snapshot is still the one from before the first apply after the restore.
run "snapshot_survives_the_restore" {
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
        permission_grant_policies         = ["ManagePermissionGrantsForSelf.microsoft-user-default-legacy", "ManagePermissionGrantsForOwnedResource.DeveloperConsent"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = output.prior_values["allowInvitesFrom"] == "everyone" && output.prior_values["guestUserRoleId"] == "a0b1b346-4d3e-4e8b-98f8-753987be4970"
    error_message = "The snapshot must not be recaptured."
  }
}

# An administrator changed a managed property after the apply: the restore refuses to overwrite it.
run "restore_refuses_over_a_scalar_change" {
  command = plan

  variables {
    tier                 = "free"
    restore_prior_values = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "none"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  expect_failures = [terraform_data.gate]
}

# A non-self consent entry added after the apply is kept by the restore: only the self entries are swapped.
run "restore_keeps_an_owned_resource_entry_added_later" {
  command = plan

  variables {
    tier                 = "free"
    restore_prior_values = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "ManagePermissionGrantsForOwnedResource.AddedLater", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"ManagePermissionGrantsForOwnedResource.AddedLater\",\"ManagePermissionGrantsForSelf.microsoft-user-default-legacy\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "The restore must keep entries it does not manage and put back the snapshot's self entry."
  }
}

# A self entry changed after the apply to a third policy is drift and refuses the restore.
run "restore_refuses_over_a_changed_self_entry" {
  command = plan

  variables {
    tier                 = "free"
    restore_prior_values = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-recommended"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  expect_failures = [terraform_data.gate]
}

run "restore_over_changes_overwrites_deliberately" {
  command = plan

  variables {
    tier                 = "free"
    restore_prior_values = true
    restore_over_changes = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "none"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = false
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"ManagePermissionGrantsForSelf.microsoft-user-default-legacy\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "restore_over_changes must restore the snapshot."
  }
}

run "restore_ignores_a_property_the_snapshot_left_null" {
  command = plan

  variables {
    tier                 = "free"
    restore_prior_values = true
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        allow_invites_from                = "adminsAndGuestInviters"
        guest_user_role_id                = "2af84b1e-32c8-42b7-82bc-daa82404023b"
        allow_user_consent_for_risky_apps = true
        permission_grant_policies         = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent", "managePermissionGrantsForSelf.microsoft-user-default-low"]
        allowed_to_create_apps            = true
        allowed_to_create_tenants         = true
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.policy.body) == "{\"allowInvitesFrom\":\"everyone\",\"defaultUserRolePermissions\":{\"permissionGrantPoliciesAssigned\":[\"ManagePermissionGrantsForOwnedResource.DeveloperConsent\",\"ManagePermissionGrantsForSelf.microsoft-user-default-legacy\"]},\"guestUserRoleId\":\"a0b1b346-4d3e-4e8b-98f8-753987be4970\"}"
    error_message = "A property whose snapshot value was null is not restored and not compared."
  }
}
