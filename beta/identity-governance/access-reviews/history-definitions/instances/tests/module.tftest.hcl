# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_review_history_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/accessReviews/historyDefinitions/test-parent-id/instances"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["downloadUri", "expirationDateTime", "fulfilledDateTime", "reviewHistoryPeriodEndDateTime", "reviewHistoryPeriodStartDateTime", "runDateTime", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_review_history_definition_id = "test-parent-id"
    download_uri                        = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["downloadUri"]) == jsonencode("example")
    error_message = "downloadUri must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_review_history_definition_id = "test-parent-id"
    status                              = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
