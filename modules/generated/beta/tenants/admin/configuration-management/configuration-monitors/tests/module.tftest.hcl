# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/configurationManagement/configurationMonitors"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["baseline", "createdBy", "description", "displayName", "lastModifiedBy", "mode", "parameters", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description = "example"
    baseline    = { "description" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["baseline"]) == jsonencode({ "@odata.type" = "#microsoft.graph.configurationBaseline" })
    error_message = "baseline must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    mode = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.mode]
}
