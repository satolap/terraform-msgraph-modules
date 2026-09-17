# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsBatteryHealthDeviceAppImpact"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appDisplayName", "appName", "appPublisher", "batteryUsagePercentage", "deviceId", "isForegroundApp"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_display_name  = "example"
    is_foreground_app = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDisplayName"]) == jsonencode("example")
    error_message = "appDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isForegroundApp"]) == jsonencode(false)
    error_message = "isForegroundApp must preserve typed values and omit nested nulls."
  }
}
