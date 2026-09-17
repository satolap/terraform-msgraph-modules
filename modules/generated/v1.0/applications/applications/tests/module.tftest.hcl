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
    condition     = alltrue([for key in ["addIns", "api", "appManagementPolicies", "appRoles", "authenticationBehaviors", "certification", "defaultRedirectUri", "deletedDateTime", "description", "disabledByMicrosoftStatus", "federatedIdentityCredentials", "groupMembershipClaims", "homeRealmDiscoveryPolicies", "identifierUris", "info", "isDeviceOnlyAuthSupported", "isDisabled", "isFallbackPublicClient", "keyCredentials", "logo", "managerApplications", "nativeAuthenticationApisEnabled", "notes", "oauth2RequirePostResponse", "optionalClaims", "owners", "parentalControlSettings", "passwordCredentials", "publicClient", "requestSignatureVerification", "requiredResourceAccess", "samlMetadataUrl", "serviceManagementReference", "servicePrincipalLockConfiguration", "signInAudience", "spa", "synchronization", "tags", "tokenEncryptionKeyId", "tokenIssuancePolicies", "tokenLifetimePolicies", "verifiedPublisher", "web"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name                  = "example"
    default_redirect_uri          = "example"
    is_device_only_auth_supported = false
    add_ins                       = [{}]
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
    condition     = jsonencode(msgraph_resource.this.body["addIns"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.addIn" }])
    error_message = "addIns must preserve typed values and omit nested nulls."
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
