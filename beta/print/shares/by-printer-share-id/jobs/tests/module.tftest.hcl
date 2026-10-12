# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    printer_share_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "print/shares/test-parent-id/jobs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acknowledgedDateTime", "completedDateTime", "configuration", "createdBy", "displayName", "documents", "errorCode", "isFetchable", "redirectedFrom", "redirectedTo", "status", "tasks"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    printer_share_id       = "test-parent-id"
    acknowledged_date_time = "2026-01-01T00:00:00Z"
    is_fetchable           = false
    error_code             = -2147483648
    configuration          = { "collate" = null }
    documents              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acknowledgedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "acknowledgedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isFetchable"]) == jsonencode(false)
    error_message = "isFetchable must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["errorCode"]) == jsonencode(-2147483648)
    error_message = "errorCode must preserve typed values and omit nested nulls."
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
