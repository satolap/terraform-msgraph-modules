# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_compliance_script_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceComplianceScripts/test-parent-id/deviceRunStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["detectionState", "expectedStateUpdateDateTime", "lastStateUpdateDateTime", "lastSyncDateTime", "managedDevice", "scriptError", "scriptOutput"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_compliance_script_id = "test-parent-id"
    detection_state             = "unknown"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["detectionState"]) == jsonencode("unknown")
    error_message = "detectionState must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_compliance_script_id = "test-parent-id"
    detection_state             = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.detection_state]
}
