# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/deviceHealthStatuses"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["blueScreenCount", "bootTotalDurationInSeconds", "deviceId", "deviceMake", "deviceModel", "deviceName", "healthStatus", "lastUpdatedDateTime", "osVersion", "primaryDiskType", "restartCount", "startupPerformanceScore", "tenantDisplayName", "tenantId", "topProcesses"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_id         = "example"
    blue_screen_count = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceId"]) == jsonencode("example")
    error_message = "deviceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blueScreenCount"]) == jsonencode(-2147483648)
    error_message = "blueScreenCount must preserve typed values and omit nested nulls."
  }
}
