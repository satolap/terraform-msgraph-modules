# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
    chat_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/chats/test-parent-id/operations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["attemptsCount", "createdDateTime", "error", "lastActionDateTime", "operationType", "status", "targetResourceId", "targetResourceLocation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    chat_id           = "test-parent-id"
    created_date_time = "2026-01-01T00:00:00Z"
    attempts_count    = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attemptsCount"]) == jsonencode(-2147483648)
    error_message = "attemptsCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id        = "test-parent-id"
    chat_id        = "test-parent-id"
    operation_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.operation_type]
}
