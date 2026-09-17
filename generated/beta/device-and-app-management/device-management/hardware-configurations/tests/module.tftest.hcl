# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/hardwareConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "configurationFileContent", "description", "fileName", "hardwareConfigurationFormat", "perDevicePasswordDisabled", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    configuration_file_content   = "example"
    per_device_password_disabled = false
    assignments                  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["configurationFileContent"]) == jsonencode("example")
    error_message = "configurationFileContent must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["perDevicePasswordDisabled"]) == jsonencode(false)
    error_message = "perDevicePasswordDisabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.hardwareConfigurationAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    hardware_configuration_format = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.hardware_configuration_format]
}
