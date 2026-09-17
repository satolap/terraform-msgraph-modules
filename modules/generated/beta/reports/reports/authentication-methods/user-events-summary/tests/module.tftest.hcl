# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/authenticationMethods/userEventsSummary"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["authMethod", "eventDateTime", "failureReason", "feature", "isSuccess", "userDisplayName", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    auth_method = "email"
    is_success  = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["authMethod"]) == jsonencode("email")
    error_message = "authMethod must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isSuccess"]) == jsonencode(false)
    error_message = "isSuccess must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    auth_method = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.auth_method]
}
