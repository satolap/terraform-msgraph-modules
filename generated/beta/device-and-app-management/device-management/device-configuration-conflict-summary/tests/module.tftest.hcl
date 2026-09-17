# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceConfigurationConflictSummary"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["conflictingDeviceConfigurations", "contributingSettings", "deviceCheckinsImpacted"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_checkins_impacted          = -2147483648
    conflicting_device_configurations = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceCheckinsImpacted"]) == jsonencode(-2147483648)
    error_message = "deviceCheckinsImpacted must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["conflictingDeviceConfigurations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.settingSource" }])
    error_message = "conflictingDeviceConfigurations must preserve typed values and omit nested nulls."
  }
}
