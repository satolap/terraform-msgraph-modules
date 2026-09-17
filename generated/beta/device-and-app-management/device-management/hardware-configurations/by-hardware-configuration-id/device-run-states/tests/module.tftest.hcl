# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    hardware_configuration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/hardwareConfigurations/test-parent-id/deviceRunStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignmentFilterIds", "configurationError", "configurationOutput", "configurationState", "deviceName", "internalVersion", "lastStateUpdateDateTime", "osVersion", "upn"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    hardware_configuration_id = "test-parent-id"
    assignment_filter_ids     = "example"
    internal_version          = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentFilterIds"]) == jsonencode("example")
    error_message = "assignmentFilterIds must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["internalVersion"]) == jsonencode(-2147483648)
    error_message = "internalVersion must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    hardware_configuration_id = "test-parent-id"
    configuration_state       = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.configuration_state]
}
