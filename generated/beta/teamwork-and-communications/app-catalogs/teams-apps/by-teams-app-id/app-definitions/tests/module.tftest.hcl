# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    teams_app_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "appCatalogs/teamsApps/test-parent-id/appDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedInstallationScopes", "authorization", "azureADAppId", "bot", "colorIcon", "createdBy", "dashboardCards", "description", "displayName", "version", "lastModifiedDateTime", "outlineIcon", "publishingState", "shortdescription", "teamsAppId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    teams_app_id    = "test-parent-id"
    azure_ad_app_id = "example"
    dashboard_cards = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureADAppId"]) == jsonencode("example")
    error_message = "azureADAppId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dashboardCards"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.teamsAppDashboardCardDefinition" }])
    error_message = "dashboardCards must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    teams_app_id                = "test-parent-id"
    allowed_installation_scopes = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_installation_scopes]
}
