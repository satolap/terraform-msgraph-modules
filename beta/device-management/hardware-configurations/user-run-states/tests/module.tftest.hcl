# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    hardware_configuration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/hardwareConfigurations/test-parent-id/userRunStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["errorDeviceCount", "failedDeviceCount", "lastStateUpdateDateTime", "notApplicableDeviceCount", "pendingDeviceCount", "successfulDeviceCount", "unknownDeviceCount", "upn", "userEmail", "userName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    hardware_configuration_id   = "test-parent-id"
    last_state_update_date_time = "2026-01-01T00:00:00Z"
    error_device_count          = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastStateUpdateDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastStateUpdateDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["errorDeviceCount"]) == jsonencode(-2147483648)
    error_message = "errorDeviceCount must preserve typed values and omit nested nulls."
  }
}
