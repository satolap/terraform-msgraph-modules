# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    drive_id            = "test-parent-id"
    drive_item_id       = "test-parent-id"
    workbook_comment_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "drives/test-parent-id/items/test-parent-id/workbook/comments/test-parent-id/replies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "contentType", "task"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    drive_id            = "test-parent-id"
    drive_item_id       = "test-parent-id"
    workbook_comment_id = "test-parent-id"
    content             = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }
}
