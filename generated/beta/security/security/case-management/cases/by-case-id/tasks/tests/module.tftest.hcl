# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/caseManagement/cases/test-parent-id/tasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedTo", "category", "closingNotes", "createdBy", "createdDateTime", "description", "displayName", "dueDateTime", "lastModifiedBy", "lastModifiedDateTime", "priority", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    case_id     = "test-parent-id"
    assigned_to = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedTo"]) == jsonencode("example")
    error_message = "assignedTo must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    case_id  = "test-parent-id"
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
