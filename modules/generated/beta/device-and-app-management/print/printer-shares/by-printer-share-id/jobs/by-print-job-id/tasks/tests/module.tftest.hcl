# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    printer_share_id = "test-parent-id"
    print_job_id     = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "print/printerShares/test-parent-id/jobs/test-parent-id/tasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["definition", "status", "trigger"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    printer_share_id = "test-parent-id"
    print_job_id     = "test-parent-id"
    definition       = { "createdBy" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["definition"]) == jsonencode({ "@odata.type" = "#microsoft.graph.printTaskDefinition" })
    error_message = "definition must preserve typed values and omit nested nulls."
  }
}
