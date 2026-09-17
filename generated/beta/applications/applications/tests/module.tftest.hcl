# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    display_name = "example"
  }

  assert {
    condition     = msgraph_resource.this.url == "applications"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["api", "appManagementPolicies", "appRoles", "authenticationBehaviors", "certification", "connectorGroup", "defaultRedirectUri", "deletedDateTime", "description", "disabledByMicrosoftStatus", "federatedIdentityCredentials", "groupMembershipClaims", "homeRealmDiscoveryPolicies", "identifierUris", "info", "isDeviceOnlyAuthSupported", "isDisabled", "isFallbackPublicClient", "keyCredentials", "logo", "nativeAuthenticationApisEnabled", "notes", "onPremisesPublishing", "optionalClaims", "parentalControlSettings", "passwordCredentials", "publicClient", "requestSignatureVerification", "requiredResourceAccess", "samlMetadataUrl", "serviceManagementReference", "servicePrincipalLockConfiguration", "signInAudience", "signInAudienceRestrictions", "spa", "synchronization", "tags", "tokenEncryptionKeyId", "tokenIssuancePolicies", "tokenLifetimePolicies", "verifiedPublisher", "web", "windows"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name                  = "example"
    default_redirect_uri          = "example"
    is_device_only_auth_supported = false
    sign_in_audience_restrictions = { "kind" = null }
    app_management_policies       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultRedirectUri"]) == jsonencode("example")
    error_message = "defaultRedirectUri must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDeviceOnlyAuthSupported"]) == jsonencode(false)
    error_message = "isDeviceOnlyAuthSupported must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["signInAudienceRestrictions"]) == jsonencode({ "@odata.type" = "#microsoft.graph.signInAudienceRestrictionsBase" })
    error_message = "signInAudienceRestrictions must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appManagementPolicies"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appManagementPolicy" }])
    error_message = "appManagementPolicies must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    display_name                       = "example"
    native_authentication_apis_enabled = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.native_authentication_apis_enabled]
}
