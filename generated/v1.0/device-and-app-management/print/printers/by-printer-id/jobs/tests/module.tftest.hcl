# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    printer_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "print/printers/test-parent-id/jobs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["configuration", "createdBy", "documents", "isFetchable", "redirectedFrom", "redirectedTo", "status", "tasks"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    printer_id      = "test-parent-id"
    redirected_from = "example"
    is_fetchable    = false
    configuration   = { "collate" = null }
    documents       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["redirectedFrom"]) == jsonencode("example")
    error_message = "redirectedFrom must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isFetchable"]) == jsonencode(false)
    error_message = "isFetchable must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["configuration"]) == jsonencode({ "@odata.type" = "#microsoft.graph.printJobConfiguration" })
    error_message = "configuration must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["documents"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.printDocument" }])
    error_message = "documents must preserve typed values and omit nested nulls."
  }
}
