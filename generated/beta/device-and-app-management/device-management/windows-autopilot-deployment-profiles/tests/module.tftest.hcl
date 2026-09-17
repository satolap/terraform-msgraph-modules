# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsAutopilotDeploymentProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedDevices", "assignments", "description", "deviceNameTemplate", "deviceType", "displayName", "enrollmentStatusScreenSettings", "hardwareHashExtractionEnabled", "locale", "managementServiceAppId", "outOfBoxExperienceSetting", "preprovisioningAllowed", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description                      = "example"
    hardware_hash_extraction_enabled = false
    assigned_devices                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hardwareHashExtractionEnabled"]) == jsonencode(false)
    error_message = "hardwareHashExtractionEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedDevices"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.windowsAutopilotDeviceIdentity" }])
    error_message = "assignedDevices must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.device_type]
}
