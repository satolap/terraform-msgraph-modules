# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/androidManagedStoreAppConfigurationSchemas"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["exampleJson", "nestedSchemaItems", "schemaItems"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    example_json        = "example"
    nested_schema_items = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["exampleJson"]) == jsonencode("example")
    error_message = "exampleJson must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["nestedSchemaItems"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.androidManagedStoreAppConfigurationSchemaItem" }])
    error_message = "nestedSchemaItems must preserve typed values and omit nested nulls."
  }
}
