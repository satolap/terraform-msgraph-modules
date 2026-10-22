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

run "rejects_missing_allow_invites_from" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { guest_user_role_id = "a0b1b346-4d3e-4e8b-98f8-753987be4970", allow_user_consent_for_risky_apps = false, permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_missing_guest_role" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", allow_user_consent_for_risky_apps = false, permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_null_allow_invites_from" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = null, guest_user_role_id = "a0b1b346-4d3e-4e8b-98f8-753987be4970", allow_user_consent_for_risky_apps = false, permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_null_guest_role" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", guest_user_role_id = null, allow_user_consent_for_risky_apps = false, permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_non_string_guest_role" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", guest_user_role_id = 5, allow_user_consent_for_risky_apps = false, permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_non_list_consent_policies" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", guest_user_role_id = "a0b1b346-4d3e-4e8b-98f8-753987be4970", allow_user_consent_for_risky_apps = false, permission_grant_policies = "managePermissionGrantsForSelf.x", allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_non_string_consent_entry" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", guest_user_role_id = "a0b1b346-4d3e-4e8b-98f8-753987be4970", allow_user_consent_for_risky_apps = false, permission_grant_policies = [1], allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_non_boolean_risky_apps" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", guest_user_role_id = "a0b1b346-4d3e-4e8b-98f8-753987be4970", allow_user_consent_for_risky_apps = "maybe", permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = true, allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_non_boolean_create_apps" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", guest_user_role_id = "a0b1b346-4d3e-4e8b-98f8-753987be4970", allow_user_consent_for_risky_apps = false, permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = "yes", allowed_to_create_tenants = true } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_non_boolean_create_tenants" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = { output = { allow_invites_from = "everyone", guest_user_role_id = "a0b1b346-4d3e-4e8b-98f8-753987be4970", allow_user_consent_for_risky_apps = false, permission_grant_policies = ["ManagePermissionGrantsForOwnedResource.DeveloperConsent"], allowed_to_create_apps = true, allowed_to_create_tenants = "yes" } }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "rejects_missing_policies_export" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.consent_policies[0]
    values = { output = { next_link = null } }
  }

  expect_failures = [data.msgraph_resource.consent_policies[0]]
}

run "rejects_missing_paging_export" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.consent_policies[0]
    values = { output = { policies = [{ id = "microsoft-user-default-low" }] } }
  }

  expect_failures = [data.msgraph_resource.consent_policies[0]]
}

run "rejects_unresolved_policy_page" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.consent_policies[0]
    values = { output = { policies = [{ id = "microsoft-user-default-low" }], next_link = "https://graph.microsoft.com/v1.0/policies/permissionGrantPolicies?$skiptoken=synthetic" } }
  }

  expect_failures = [data.msgraph_resource.consent_policies[0]]
}

run "rejects_policy_without_id" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.consent_policies[0]
    values = { output = { policies = [{ id = null }], next_link = null } }
  }

  expect_failures = [data.msgraph_resource.consent_policies[0]]
}
