# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    file_storage_container_id    = "test-parent-id"
    share_point_migration_job_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "storage/fileStorage/containers/test-parent-id/migrationJobs/test-parent-id/progressEvents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in [] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}
