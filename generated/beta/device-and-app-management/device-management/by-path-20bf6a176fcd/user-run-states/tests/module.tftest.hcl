# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_custom_attribute_shell_script_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceCustomAttributeShellScripts/test-parent-id/userRunStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deviceRunStates", "errorDeviceCount", "successDeviceCount", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_custom_attribute_shell_script_id = "test-parent-id"
    user_principal_name                     = "example"
    error_device_count                      = -2147483648
    device_run_states                       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["userPrincipalName"]) == jsonencode("example")
    error_message = "userPrincipalName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["errorDeviceCount"]) == jsonencode(-2147483648)
    error_message = "errorDeviceCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceRunStates"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementScriptDeviceState" }])
    error_message = "deviceRunStates must preserve typed values and omit nested nulls."
  }
}
