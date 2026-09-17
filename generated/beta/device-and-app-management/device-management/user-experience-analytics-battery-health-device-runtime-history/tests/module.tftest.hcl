# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsBatteryHealthDeviceRuntimeHistory"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deviceId", "estimatedRuntimeInMinutes", "runtimeDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_id                    = "example"
    estimated_runtime_in_minutes = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceId"]) == jsonencode("example")
    error_message = "deviceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["estimatedRuntimeInMinutes"]) == jsonencode(-2147483648)
    error_message = "estimatedRuntimeInMinutes must preserve typed values and omit nested nulls."
  }
}
