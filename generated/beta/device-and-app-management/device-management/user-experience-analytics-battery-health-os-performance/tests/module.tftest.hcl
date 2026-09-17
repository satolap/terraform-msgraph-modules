# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsBatteryHealthOsPerformance"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activeDevices", "averageBatteryAgeInDays", "averageEstimatedRuntimeInMinutes", "averageMaxCapacityPercentage", "meanFullBatteryDrainCount", "medianEstimatedRuntimeInMinutes", "medianFullBatteryDrainCount", "medianMaxCapacityPercentage", "osBatteryHealthScore", "osBuildNumber", "osHealthStatus", "osVersion"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    os_build_number = "example"
    active_devices  = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["osBuildNumber"]) == jsonencode("example")
    error_message = "osBuildNumber must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activeDevices"]) == jsonencode(-2147483648)
    error_message = "activeDevices must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    os_health_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.os_health_status]
}
