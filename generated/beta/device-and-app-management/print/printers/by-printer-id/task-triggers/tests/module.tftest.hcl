# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    printer_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "print/printers/test-parent-id/taskTriggers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["definition", "event"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    printer_id = "test-parent-id"
    event      = "jobStarted"
    definition = { "createdBy" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["event"]) == jsonencode("jobStarted")
    error_message = "event must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["definition"]) == jsonencode({ "@odata.type" = "#microsoft.graph.printTaskDefinition" })
    error_message = "definition must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    printer_id = "test-parent-id"
    event      = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.event]
}
