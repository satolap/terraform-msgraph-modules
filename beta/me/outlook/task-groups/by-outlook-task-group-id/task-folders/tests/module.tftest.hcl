# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    outlook_task_group_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/outlook/taskGroups/test-parent-id/taskFolders"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["changeKey", "isDefaultFolder", "name", "parentGroupKey"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    outlook_task_group_id = "test-parent-id"
    change_key            = "example"
    is_default_folder     = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["changeKey"]) == jsonencode("example")
    error_message = "changeKey must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefaultFolder"]) == jsonencode(false)
    error_message = "isDefaultFolder must preserve typed values and omit nested nulls."
  }
}
