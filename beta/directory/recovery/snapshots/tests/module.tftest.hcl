# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "directory/recovery/snapshots"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "recoveryJobs", "recoveryPreviewJobs", "totalChangedObjects"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time     = "2026-01-01T00:00:00Z"
    total_changed_objects = -2147483648
    recovery_jobs         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["totalChangedObjects"]) == jsonencode(-2147483648)
    error_message = "totalChangedObjects must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["recoveryJobs"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.entraRecoveryServices.recoveryJob" }])
    error_message = "recoveryJobs must preserve typed values and omit nested nulls."
  }
}
