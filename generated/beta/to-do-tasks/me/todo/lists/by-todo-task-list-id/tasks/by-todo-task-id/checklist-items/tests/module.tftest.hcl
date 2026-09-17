# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    todo_task_list_id = "test-parent-id"
    todo_task_id      = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/todo/lists/test-parent-id/tasks/test-parent-id/checklistItems"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["checkedDateTime", "createdDateTime", "displayName", "isChecked"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    todo_task_list_id = "test-parent-id"
    todo_task_id      = "test-parent-id"
    checked_date_time = "2026-01-01T00:00:00Z"
    is_checked        = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["checkedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "checkedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isChecked"]) == jsonencode(false)
    error_message = "isChecked must preserve typed values and omit nested nulls."
  }
}
