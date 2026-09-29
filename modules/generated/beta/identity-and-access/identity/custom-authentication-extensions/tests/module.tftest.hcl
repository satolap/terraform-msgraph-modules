# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.onAttributeCollectionStartCustomExtension"
  }

  assert {
    condition     = msgraph_resource.this.url == "identity/customAuthenticationExtensions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["authenticationConfiguration", "behaviorOnError", "clientConfiguration", "description", "displayName", "endpointConfiguration"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type           = "#microsoft.graph.onAttributeCollectionStartCustomExtension"
    description          = "example"
    client_configuration = { "maximumRetries" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.onAttributeCollectionStartCustomExtension")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clientConfiguration"]) == jsonencode({ "@odata.type" = "#microsoft.graph.customExtensionClientConfiguration" })
    error_message = "clientConfiguration must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
