# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    shared_drive_item_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "shares/test-parent-id/list/items"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["analytics", "contentType", "description", "documentSetVersions", "driveItem", "fields", "name", "parentReference", "versions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    shared_drive_item_id  = "test-parent-id"
    description           = "example"
    document_set_versions = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["documentSetVersions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.documentSetVersion" }])
    error_message = "documentSetVersions must preserve typed values and omit nested nulls."
  }
}
