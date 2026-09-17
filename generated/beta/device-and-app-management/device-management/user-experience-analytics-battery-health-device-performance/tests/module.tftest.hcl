# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsBatteryHealthDevicePerformance"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["batteryAgeInDays", "deviceBatteriesDetails", "deviceBatteryCount", "deviceBatteryHealthScore", "deviceBatteryTags", "deviceId", "deviceManufacturerName", "deviceModelName", "deviceName", "estimatedRuntimeInMinutes", "fullBatteryDrainCount", "healthStatus", "manufacturer", "maxCapacityPercentage", "model"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_id                = "example"
    battery_age_in_days      = -2147483648
    device_batteries_details = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceId"]) == jsonencode("example")
    error_message = "deviceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["batteryAgeInDays"]) == jsonencode(-2147483648)
    error_message = "batteryAgeInDays must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceBatteriesDetails"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.userExperienceAnalyticsDeviceBatteryDetail" }])
    error_message = "deviceBatteriesDetails must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    health_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.health_status]
}
