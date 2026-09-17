# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "external/connections/test-parent-id/items"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acl", "activities", "content", "informationProtectionLabel", "properties"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    acl                    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acl"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.externalConnectors.acl" }])
    error_message = "acl must preserve typed values and omit nested nulls."
  }
}
