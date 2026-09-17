# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id = "test-parent-id"
    list_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/lists/test-parent-id/contentTypes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["associatedHubsUrls", "base", "baseTypes", "columnLinks", "columnPositions", "columns", "description", "documentSet", "documentTemplate", "group", "hidden", "inheritedFrom", "isBuiltIn", "name", "order", "parentId", "propagateChanges", "readOnly", "sealed"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id              = "test-parent-id"
    list_id              = "test-parent-id"
    description          = "example"
    hidden               = false
    associated_hubs_urls = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hidden"]) == jsonencode(false)
    error_message = "hidden must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["associatedHubsUrls"]) == jsonencode(["example"])
    error_message = "associatedHubsUrls must preserve typed values and omit nested nulls."
  }
}
