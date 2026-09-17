# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    teams_app_id            = "test-parent-id"
    teams_app_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "appCatalogs/teamsApps/test-parent-id/appDefinitions/test-parent-id/dashboardCards"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["contentSource", "defaultSize", "description", "displayName", "icon", "pickerGroupId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    teams_app_id            = "test-parent-id"
    teams_app_definition_id = "test-parent-id"
    description             = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    teams_app_id            = "test-parent-id"
    teams_app_definition_id = "test-parent-id"
    default_size            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.default_size]
}
