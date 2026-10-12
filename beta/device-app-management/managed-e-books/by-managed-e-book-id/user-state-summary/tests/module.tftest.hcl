# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    managed_e_book_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/managedEBooks/test-parent-id/userStateSummary"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deviceStates", "failedDeviceCount", "installedDeviceCount", "notInstalledDeviceCount", "userName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    managed_e_book_id   = "test-parent-id"
    user_name           = "example"
    failed_device_count = -2147483648
    device_states       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["userName"]) == jsonencode("example")
    error_message = "userName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["failedDeviceCount"]) == jsonencode(-2147483648)
    error_message = "failedDeviceCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceStates"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceInstallState" }])
    error_message = "deviceStates must preserve typed values and omit nested nulls."
  }
}
