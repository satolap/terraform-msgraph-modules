# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/managedDeviceEncryptionStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["advancedBitLockerStates", "deviceName", "deviceType", "encryptionPolicySettingState", "encryptionReadinessState", "encryptionState", "fileVaultStates", "osVersion", "policyDetails", "tpmSpecificationVersion", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_name    = "example"
    policy_details = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceName"]) == jsonencode("example")
    error_message = "deviceName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["policyDetails"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.encryptionReportPolicyDetails" }])
    error_message = "policyDetails must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    advanced_bit_locker_states = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.advanced_bit_locker_states]
}
