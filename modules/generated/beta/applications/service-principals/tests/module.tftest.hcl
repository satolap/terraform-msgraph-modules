# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    app_id = "example"
  }

  assert {
    condition     = msgraph_resource.this.url == "servicePrincipals"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountEnabled", "addIns", "alternativeNames", "appDescription", "appDisplayName", "appManagementPolicies", "appOwnerOrganizationId", "appRoleAssignedTo", "appRoleAssignmentRequired", "appRoleAssignments", "appRoles", "claimsMappingPolicies", "claimsPolicy", "customSecurityAttributes", "delegatedPermissionClassifications", "deletedDateTime", "description", "disabledByMicrosoftStatus", "displayName", "endpoints", "errorUrl", "federatedIdentityCredentials", "homeRealmDiscoveryPolicies", "homepage", "info", "isDisabled", "keyCredentials", "licenseDetails", "loginUrl", "logoutUrl", "notes", "notificationEmailAddresses", "owners", "passwordCredentials", "permissionGrantPreApprovalPolicies", "preferredSingleSignOnMode", "preferredTokenSigningKeyEndDateTime", "preferredTokenSigningKeyThumbprint", "publishedPermissionScopes", "publisherName", "remoteDesktopSecurityConfiguration", "replyUrls", "samlMetadataUrl", "samlSingleSignOnSettings", "servicePrincipalNames", "servicePrincipalType", "synchronization", "tags", "tokenEncryptionKeyId", "tokenIssuancePolicies", "tokenLifetimePolicies", "transitiveMemberOf", "verifiedPublisher"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_id          = "example"
    app_description = "example"
    account_enabled = false
    add_ins         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appId"]) == jsonencode("example")
    error_message = "appId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDescription"]) == jsonencode("example")
    error_message = "appDescription must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountEnabled"]) == jsonencode(false)
    error_message = "accountEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["addIns"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.addIn" }])
    error_message = "addIns must preserve typed values and omit nested nulls."
  }
}
