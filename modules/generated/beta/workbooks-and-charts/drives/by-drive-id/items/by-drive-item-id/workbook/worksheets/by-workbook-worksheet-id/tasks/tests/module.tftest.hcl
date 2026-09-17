# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    drive_id              = "test-parent-id"
    drive_item_id         = "test-parent-id"
    workbook_worksheet_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "drives/test-parent-id/items/test-parent-id/workbook/worksheets/test-parent-id/tasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignees", "changes", "comment", "completedBy", "completedDateTime", "createdBy", "createdDateTime", "percentComplete", "priority", "startAndDueDateTime", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    drive_id              = "test-parent-id"
    drive_item_id         = "test-parent-id"
    workbook_worksheet_id = "test-parent-id"
    completed_date_time   = "2026-01-01T00:00:00Z"
    percent_complete      = -2147483648
    assignees             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "completedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["percentComplete"]) == jsonencode(-2147483648)
    error_message = "percentComplete must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignees"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.workbookEmailIdentity" }])
    error_message = "assignees must preserve typed values and omit nested nulls."
  }
}
