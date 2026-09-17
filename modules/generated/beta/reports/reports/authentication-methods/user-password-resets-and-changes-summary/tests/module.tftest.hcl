# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/authenticationMethods/userPasswordResetsAndChangesSummary"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["aggregatedDateTime", "changePasswordSelfServiceCount", "passwordResetsByAdminCount", "passwordResetsSelfServiceCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    aggregated_date_time               = "2026-01-01T00:00:00Z"
    change_password_self_service_count = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["aggregatedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "aggregatedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["changePasswordSelfServiceCount"]) == jsonencode(0)
    error_message = "changePasswordSelfServiceCount must preserve typed values and omit nested nulls."
  }
}
