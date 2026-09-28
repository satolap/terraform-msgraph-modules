# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.cloudPcBulkCreateSnapshot"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/bulkActions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionSummary", "cloudPcIds", "createdDateTime", "displayName", "scheduledDuringMaintenanceWindow"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type                          = "#microsoft.graph.cloudPcBulkCreateSnapshot"
    created_date_time                   = "2026-01-01T00:00:00Z"
    scheduled_during_maintenance_window = false
    action_summary                      = { "failedCount" = null }
    cloud_pc_ids                        = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.cloudPcBulkCreateSnapshot")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["scheduledDuringMaintenanceWindow"]) == jsonencode(false)
    error_message = "scheduledDuringMaintenanceWindow must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionSummary"]) == jsonencode({ "@odata.type" = "#microsoft.graph.cloudPcBulkActionSummary" })
    error_message = "actionSummary must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["cloudPcIds"]) == jsonencode(["example"])
    error_message = "cloudPcIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
