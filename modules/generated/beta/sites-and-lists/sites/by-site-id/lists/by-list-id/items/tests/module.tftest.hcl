# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id = "test-parent-id"
    list_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/lists/test-parent-id/items"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activities", "analytics", "contentType", "createdByUser", "deleted", "description", "documentSetVersions", "driveItem", "fields", "lastModifiedByUser", "name", "parentReference", "versions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id     = "test-parent-id"
    list_id     = "test-parent-id"
    description = "example"
    activities  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activities"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.itemActivityOLD" }])
    error_message = "activities must preserve typed values and omit nested nulls."
  }
}
