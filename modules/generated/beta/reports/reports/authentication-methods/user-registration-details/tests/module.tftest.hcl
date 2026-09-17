# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/authenticationMethods/userRegistrationDetails"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["defaultMfaMethod", "isAdmin", "isMfaCapable", "isMfaRegistered", "isPasswordlessCapable", "isSsprCapable", "isSsprEnabled", "isSsprRegistered", "isSystemPreferredAuthenticationMethodEnabled", "lastUpdatedDateTime", "methodsRegistered", "systemPreferredAuthenticationMethods", "userDisplayName", "userPreferredMethodForSecondaryAuthentication", "userPrincipalName", "userType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    last_updated_date_time = "2026-01-01T00:00:00Z"
    is_admin               = false
    methods_registered     = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastUpdatedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastUpdatedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAdmin"]) == jsonencode(false)
    error_message = "isAdmin must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["methodsRegistered"]) == jsonencode(["example"])
    error_message = "methodsRegistered must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    default_mfa_method = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.default_mfa_method]
}
