# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    drive_id                  = "test-parent-id"
    drive_item_id             = "test-parent-id"
    workbook_comment_id       = "test-parent-id"
    workbook_comment_reply_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "drives/test-parent-id/items/test-parent-id/workbook/comments/test-parent-id/replies/test-parent-id/task/changes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignee", "changedBy", "commentId", "createdDateTime", "dueDateTime", "percentComplete", "priority", "startDateTime", "title", "type", "undoChangeId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    drive_id                  = "test-parent-id"
    drive_item_id             = "test-parent-id"
    workbook_comment_id       = "test-parent-id"
    workbook_comment_reply_id = "test-parent-id"
    comment_id                = "example"
    percent_complete          = -2147483648
    changed_by                = { "displayName" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["commentId"]) == jsonencode("example")
    error_message = "commentId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["percentComplete"]) == jsonencode(-2147483648)
    error_message = "percentComplete must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["changedBy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.workbookEmailIdentity" })
    error_message = "changedBy must preserve typed values and omit nested nulls."
  }
}
