# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    todo_task_list_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/todo/lists/test-parent-id/tasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["attachmentSessions", "attachments", "body", "bodyLastModifiedDateTime", "categories", "checklistItems", "completedDateTime", "createdDateTime", "dueDateTime", "extensions", "hasAttachments", "importance", "isReminderOn", "lastModifiedDateTime", "linkedResources", "recurrence", "reminderDateTime", "singleValueExtendedProperties", "startDateTime", "status", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    todo_task_list_id            = "test-parent-id"
    body_last_modified_date_time = "2026-01-01T00:00:00Z"
    has_attachments              = false
    attachment_sessions          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["bodyLastModifiedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "bodyLastModifiedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasAttachments"]) == jsonencode(false)
    error_message = "hasAttachments must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attachmentSessions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.attachmentSession" }])
    error_message = "attachmentSessions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    todo_task_list_id = "test-parent-id"
    importance        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.importance]
}
