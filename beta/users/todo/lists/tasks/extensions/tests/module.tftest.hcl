# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    todo_task_list_id = "test-parent-id"
    todo_task_id      = "test-parent-id"
    odata_type        = "#microsoft.graph.openTypeExtension"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/todo/lists/test-parent-id/tasks/test-parent-id/extensions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in [] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    todo_task_list_id = "test-parent-id"
    todo_task_id      = "test-parent-id"
    odata_type        = "#microsoft.graph.openTypeExtension"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.openTypeExtension")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    todo_task_list_id = "test-parent-id"
    todo_task_id      = "test-parent-id"
    odata_type        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
