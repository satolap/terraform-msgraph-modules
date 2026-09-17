# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    printer_share_id = "test-parent-id"
    print_job_id     = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "print/printerShares/test-parent-id/jobs/test-parent-id/documents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["configuration", "downloadedDateTime", "uploadedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    printer_share_id     = "test-parent-id"
    print_job_id         = "test-parent-id"
    downloaded_date_time = "2026-01-01T00:00:00Z"
    configuration        = { "collate" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["downloadedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "downloadedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["configuration"]) == jsonencode({ "@odata.type" = "#microsoft.graph.printerDocumentConfiguration" })
    error_message = "configuration must preserve typed values and omit nested nulls."
  }
}
