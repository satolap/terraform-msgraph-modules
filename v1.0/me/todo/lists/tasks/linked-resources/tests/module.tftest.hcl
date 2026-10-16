# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    todo_task_list_id = "test-parent-id"
    todo_task_id      = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/todo/lists/test-parent-id/tasks/test-parent-id/linkedResources"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applicationName", "displayName", "externalId", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    todo_task_list_id = "test-parent-id"
    todo_task_id      = "test-parent-id"
    application_name  = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationName"]) == jsonencode("example")
    error_message = "applicationName must preserve typed values and omit nested nulls."
  }
}
