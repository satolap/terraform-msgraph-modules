# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_management_intent_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/intents/test-parent-id/deviceSettingStateSummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["compliantCount", "conflictCount", "errorCount", "nonCompliantCount", "notApplicableCount", "remediatedCount", "settingName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_management_intent_id = "test-parent-id"
    setting_name                = "example"
    compliant_count             = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingName"]) == jsonencode("example")
    error_message = "settingName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["compliantCount"]) == jsonencode(-2147483648)
    error_message = "compliantCount must preserve typed values and omit nested nulls."
  }
}
