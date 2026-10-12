# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/privilegedAccess/customExtensions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["authenticationConfiguration", "clientConfiguration", "customAttributes", "description", "displayName", "endpointConfiguration", "resourceType", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description          = "example"
    client_configuration = { "maximumRetries" = null }
    custom_attributes    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clientConfiguration"]) == jsonencode({ "@odata.type" = "#microsoft.graph.customExtensionClientConfiguration" })
    error_message = "clientConfiguration must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customAttributes"]) == jsonencode(["example"])
    error_message = "customAttributes must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    resource_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.resource_type]
}
