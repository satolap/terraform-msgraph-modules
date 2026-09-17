# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/deviceAppManagementTasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedTo", "category", "createdDateTime", "creator", "creatorNotes", "description", "displayName", "dueDateTime", "priority", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
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
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
