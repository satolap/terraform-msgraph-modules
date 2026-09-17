# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "connections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activitySettings", "configuration", "connectorId", "contentCategory", "description", "groups", "items", "name", "operations", "schema", "searchSettings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    connector_id = "example"
    groups       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectorId"]) == jsonencode("example")
    error_message = "connectorId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["groups"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.externalConnectors.externalGroup" }])
    error_message = "groups must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    content_category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.content_category]
}
