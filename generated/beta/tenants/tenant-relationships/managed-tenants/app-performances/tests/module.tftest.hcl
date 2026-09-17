# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/appPerformances"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appFriendlyName", "appName", "appPublisher", "lastUpdatedDateTime", "meanTimeToFailureInMinutes", "tenantDisplayName", "tenantId", "totalActiveDeviceCount", "totalAppCrashCount", "totalAppFreezeCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_friendly_name               = "example"
    mean_time_to_failure_in_minutes = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appFriendlyName"]) == jsonencode("example")
    error_message = "appFriendlyName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["meanTimeToFailureInMinutes"]) == jsonencode(-2147483648)
    error_message = "meanTimeToFailureInMinutes must preserve typed values and omit nested nulls."
  }
}
