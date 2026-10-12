# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    terms_and_conditions_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/termsAndConditions/test-parent-id/acceptanceStatuses"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acceptedDateTime", "acceptedVersion", "termsAndConditions", "userDisplayName", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    terms_and_conditions_id = "test-parent-id"
    accepted_date_time      = "2026-01-01T00:00:00Z"
    accepted_version        = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acceptedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "acceptedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acceptedVersion"]) == jsonencode(-2147483648)
    error_message = "acceptedVersion must preserve typed values and omit nested nulls."
  }
}
