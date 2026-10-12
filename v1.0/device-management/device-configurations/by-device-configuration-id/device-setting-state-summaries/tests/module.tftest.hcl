# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_configuration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceConfigurations/test-parent-id/deviceSettingStateSummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["compliantDeviceCount", "conflictDeviceCount", "errorDeviceCount", "instancePath", "nonCompliantDeviceCount", "notApplicableDeviceCount", "remediatedDeviceCount", "settingName", "unknownDeviceCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_configuration_id = "test-parent-id"
    instance_path           = "example"
    compliant_device_count  = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["instancePath"]) == jsonencode("example")
    error_message = "instancePath must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["compliantDeviceCount"]) == jsonencode(-2147483648)
    error_message = "compliantDeviceCount must preserve typed values and omit nested nulls."
  }
}
