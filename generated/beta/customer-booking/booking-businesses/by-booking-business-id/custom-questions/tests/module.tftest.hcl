# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "bookingBusinesses/test-parent-id/customQuestions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["answerInputType", "answerOptions", "createdDateTime", "displayName", "lastUpdatedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
    created_date_time   = "2026-01-01T00:00:00Z"
    answer_options      = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["answerOptions"]) == jsonencode(["example"])
    error_message = "answerOptions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
    answer_input_type   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.answer_input_type]
}
