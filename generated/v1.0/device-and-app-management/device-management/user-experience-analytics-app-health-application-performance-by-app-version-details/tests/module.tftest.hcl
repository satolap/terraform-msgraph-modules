# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsAppHealthApplicationPerformanceByAppVersionDetails"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appCrashCount", "appDisplayName", "appName", "appPublisher", "appVersion", "isLatestUsedVersion"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_display_name       = "example"
    is_latest_used_version = false
    app_crash_count        = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDisplayName"]) == jsonencode("example")
    error_message = "appDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isLatestUsedVersion"]) == jsonencode(false)
    error_message = "isLatestUsedVersion must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appCrashCount"]) == jsonencode(-2147483648)
    error_message = "appCrashCount must preserve typed values and omit nested nulls."
  }
}
