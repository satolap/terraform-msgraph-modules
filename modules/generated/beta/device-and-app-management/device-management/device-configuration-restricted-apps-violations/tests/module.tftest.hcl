# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceConfigurationRestrictedAppsViolations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deviceConfigurationId", "deviceConfigurationName", "deviceName", "managedDeviceId", "platformType", "restrictedApps", "restrictedAppsState", "userId", "userName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_configuration_id = "example"
    restricted_apps         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceConfigurationId"]) == jsonencode("example")
    error_message = "deviceConfigurationId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["restrictedApps"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedDeviceReportedApp" }])
    error_message = "restrictedApps must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    platform_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platform_type]
}
