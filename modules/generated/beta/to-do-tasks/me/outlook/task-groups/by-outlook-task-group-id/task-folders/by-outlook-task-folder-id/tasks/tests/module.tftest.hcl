# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    outlook_task_group_id  = "test-parent-id"
    outlook_task_folder_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/outlook/taskGroups/test-parent-id/taskFolders/test-parent-id/tasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["body", "categories", "completedDateTime", "createdDateTime", "dueDateTime", "hasAttachments", "importance", "isReminderOn", "lastModifiedDateTime", "owner", "parentFolderId", "recurrence", "reminderDateTime", "sensitivity", "startDateTime", "status", "subject"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    outlook_task_group_id  = "test-parent-id"
    outlook_task_folder_id = "test-parent-id"
    created_date_time      = "2026-01-01T00:00:00Z"
    has_attachments        = false
    categories             = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasAttachments"]) == jsonencode(false)
    error_message = "hasAttachments must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categories"]) == jsonencode(["example"])
    error_message = "categories must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    outlook_task_group_id  = "test-parent-id"
    outlook_task_folder_id = "test-parent-id"
    importance             = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.importance]
}
