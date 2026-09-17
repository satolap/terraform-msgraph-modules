# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    file_storage_container_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "storage/fileStorage/containers/test-parent-id/migrationJobs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["containerInfo", "progressEvents"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    file_storage_container_id = "test-parent-id"
    container_info            = {}
    progress_events           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["containerInfo"]) == jsonencode({ "@odata.type" = "#microsoft.graph.sharePointMigrationContainerInfo" })
    error_message = "containerInfo must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["progressEvents"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.sharePointMigrationEvent" }])
    error_message = "progressEvents must preserve typed values and omit nested nulls."
  }
}
