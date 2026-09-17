# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "storage/fileStorage/containers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["archivalDetails", "assignedSensitivityLabel", "columns", "customProperties", "description", "displayName", "externalGroupId", "informationBarrier", "migrationJobs", "permissions", "settings", "sharePointGroups"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description = "example"
    settings    = { "isItemVersioningEnabled" = null }
    columns     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.fileStorageContainerSettings" })
    error_message = "settings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["columns"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.columnDefinition" }])
    error_message = "columns must preserve typed values and omit nested nulls."
  }
}
