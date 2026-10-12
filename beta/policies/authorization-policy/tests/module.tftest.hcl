# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "policies/authorizationPolicy"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowEmailVerifiedUsersToJoinOrganization", "allowInvitesFrom", "allowUserConsentForRiskyApps", "allowedToSignUpEmailBasedSubscriptions", "allowedToUseSSPR", "blockMsolPowerShell", "defaultUserRoleOverrides", "defaultUserRolePermissions", "deletedDateTime", "description", "displayName", "enabledPreviewFeatures", "guestUserRoleId", "permissionGrantPolicyIdsAssignedToDefaultUserRole"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allow_invites_from                              = "none"
    allow_email_verified_users_to_join_organization = false
    default_user_role_permissions                   = { "allowedToCreateApps" = null }
    default_user_role_overrides                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowInvitesFrom"]) == jsonencode("none")
    error_message = "allowInvitesFrom must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowEmailVerifiedUsersToJoinOrganization"]) == jsonencode(false)
    error_message = "allowEmailVerifiedUsersToJoinOrganization must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultUserRolePermissions"]) == jsonencode({ "@odata.type" = "#microsoft.graph.defaultUserRolePermissions" })
    error_message = "defaultUserRolePermissions must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultUserRoleOverrides"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.defaultUserRoleOverride" }])
    error_message = "defaultUserRoleOverrides must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allow_invites_from = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allow_invites_from]
}
