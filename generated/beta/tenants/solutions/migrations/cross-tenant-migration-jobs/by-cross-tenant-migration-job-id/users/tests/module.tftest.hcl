# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    cross_tenant_migration_job_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/migrations/crossTenantMigrationJobs/test-parent-id/users"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["currentStatus", "lastUpdatedDateTime", "taskType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    cross_tenant_migration_job_id = "test-parent-id"
    last_updated_date_time        = "2026-01-01T00:00:00Z"
    current_status                = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastUpdatedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastUpdatedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["currentStatus"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.crossTenantMigrationServiceStatusDetails" }])
    error_message = "currentStatus must preserve typed values and omit nested nulls."
  }
}
