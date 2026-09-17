# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceCompliancePolicySettingStateSummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["compliantDeviceCount", "conflictDeviceCount", "deviceComplianceSettingStates", "errorDeviceCount", "nonCompliantDeviceCount", "notApplicableDeviceCount", "platformType", "remediatedDeviceCount", "setting", "settingName", "unknownDeviceCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    platform_type                    = "android"
    compliant_device_count           = -2147483648
    device_compliance_setting_states = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["platformType"]) == jsonencode("android")
    error_message = "platformType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["compliantDeviceCount"]) == jsonencode(-2147483648)
    error_message = "compliantDeviceCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceComplianceSettingStates"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceComplianceSettingState" }])
    error_message = "deviceComplianceSettingStates must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    platform_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platform_type]
}
