# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsDevicePerformance"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["averageBlueScreens", "averageRestarts", "blueScreenCount", "bootScore", "coreBootTimeInMs", "coreLoginTimeInMs", "deviceCount", "deviceName", "diskType", "groupPolicyBootTimeInMs", "groupPolicyLoginTimeInMs", "healthStatus", "loginScore", "manufacturer", "model", "modelStartupPerformanceScore", "operatingSystemVersion", "responsiveDesktopTimeInMs", "restartCount", "startupPerformanceScore"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_name       = "example"
    blue_screen_count = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceName"]) == jsonencode("example")
    error_message = "deviceName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blueScreenCount"]) == jsonencode(-2147483648)
    error_message = "blueScreenCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    disk_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.disk_type]
}
