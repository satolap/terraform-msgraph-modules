# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "connections/test-parent-id/groups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "members"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    description            = "example"
    members                = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["members"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.externalConnectors.identity" }])
    error_message = "members must preserve typed values and omit nested nulls."
  }
}
