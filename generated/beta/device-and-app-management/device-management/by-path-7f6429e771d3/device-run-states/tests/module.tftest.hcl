# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_shell_script_id                 = "test-parent-id"
    device_management_script_user_state_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceShellScripts/test-parent-id/userRunStates/test-parent-id/deviceRunStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["errorCode", "errorDescription", "lastStateUpdateDateTime", "managedDevice", "resultMessage", "runState"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_shell_script_id                 = "test-parent-id"
    device_management_script_user_state_id = "test-parent-id"
    error_description                      = "example"
    error_code                             = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["errorDescription"]) == jsonencode("example")
    error_message = "errorDescription must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["errorCode"]) == jsonencode(-2147483648)
    error_message = "errorCode must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_shell_script_id                 = "test-parent-id"
    device_management_script_user_state_id = "test-parent-id"
    run_state                              = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.run_state]
}
