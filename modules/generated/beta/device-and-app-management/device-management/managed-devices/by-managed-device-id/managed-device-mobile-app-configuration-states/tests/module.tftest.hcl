# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    managed_device_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/managedDevices/test-parent-id/managedDeviceMobileAppConfigurationStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "version", "platformType", "settingCount", "settingStates", "state", "userId", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    managed_device_id = "test-parent-id"
    display_name      = "example"
    graph_version     = -2147483648
    setting_states    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode(-2147483648)
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingStates"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedDeviceMobileAppConfigurationSettingState" }])
    error_message = "settingStates must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    managed_device_id = "test-parent-id"
    platform_type     = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platform_type]
}
