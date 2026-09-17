# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/settingDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["constraints", "dependencies", "description", "displayName", "documentationUrl", "headerSubtitle", "headerTitle", "isTopLevel", "keywords", "placeholderText", "valueType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description  = "example"
    is_top_level = false
    constraints  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isTopLevel"]) == jsonencode(false)
    error_message = "isTopLevel must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["constraints"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementConstraint" }])
    error_message = "constraints must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    value_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.value_type]
}
