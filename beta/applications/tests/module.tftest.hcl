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

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    display_name    = "example"
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id", "appId"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["appManagementPolicies", "connectorGroup", "federatedIdentityCredentials", "homeRealmDiscoveryPolicies", "synchronization", "tokenIssuancePolicies", "tokenLifetimePolicies"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name                  = "example"
    default_redirect_uri          = "example"
    is_device_only_auth_supported = false
    api                           = { "acceptMappedClaims" = null }
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
    condition     = jsonencode(msgraph_resource.this.body["api"]) == jsonencode({ "@odata.type" = "#microsoft.graph.apiApplication" })
    error_message = "api must preserve typed values and omit nested nulls."
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

run "flags_enum_combination" {
  command = plan

  variables {
    display_name                       = "example"
    native_authentication_apis_enabled = "none, All"
  }

  assert {
    condition     = msgraph_resource.this.body["nativeAuthenticationApisEnabled"] == "none, All"
    error_message = "nativeAuthenticationApisEnabled must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    display_name                       = "example"
    native_authentication_apis_enabled = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.native_authentication_apis_enabled]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    display_name = "example"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    display_name = "example"
    timeouts     = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    display_name = "example"
    timeouts     = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    display_name = "example"
    timeouts     = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    display_name = "example"
    timeouts     = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
