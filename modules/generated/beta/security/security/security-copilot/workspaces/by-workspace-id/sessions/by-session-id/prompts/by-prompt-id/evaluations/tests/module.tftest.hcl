# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    workspace_id = "test-parent-id"
    session_id   = "test-parent-id"
    prompt_id    = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/securityCopilot/workspaces/test-parent-id/sessions/test-parent-id/prompts/test-parent-id/evaluations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["completedDateTime", "createdDateTime", "executionCount", "isCancelled", "lastModifiedDateTime", "result", "runStartDateTime", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    workspace_id        = "test-parent-id"
    session_id          = "test-parent-id"
    prompt_id           = "test-parent-id"
    completed_date_time = "2026-01-01T00:00:00Z"
    is_cancelled        = false
    execution_count     = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "completedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCancelled"]) == jsonencode(false)
    error_message = "isCancelled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["executionCount"]) == jsonencode(0)
    error_message = "executionCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    workspace_id = "test-parent-id"
    session_id   = "test-parent-id"
    prompt_id    = "test-parent-id"
    state        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
