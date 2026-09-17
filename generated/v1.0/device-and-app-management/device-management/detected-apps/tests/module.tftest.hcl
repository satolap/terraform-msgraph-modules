# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/detectedApps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deviceCount", "managedDevices", "platform", "publisher"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    platform        = "unknown"
    device_count    = -2147483648
    managed_devices = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["platform"]) == jsonencode("unknown")
    error_message = "platform must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceCount"]) == jsonencode(-2147483648)
    error_message = "deviceCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["managedDevices"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedDevice" }])
    error_message = "managedDevices must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    platform = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platform]
}
