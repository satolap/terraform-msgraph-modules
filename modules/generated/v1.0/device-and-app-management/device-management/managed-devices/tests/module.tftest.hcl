# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/managedDevices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["complianceState", "deviceCategory", "deviceCompliancePolicyStates", "deviceConfigurationStates", "deviceEnrollmentType", "deviceRegistrationState", "exchangeAccessState", "exchangeAccessStateReason", "logCollectionRequests", "managedDeviceName", "managedDeviceOwnerType", "managementAgent", "managementState", "notes", "partnerReportedThreatState", "users"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    compliance_state                = "unknown"
    device_compliance_policy_states = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["complianceState"]) == jsonencode("unknown")
    error_message = "complianceState must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceCompliancePolicyStates"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceCompliancePolicyState" }])
    error_message = "deviceCompliancePolicyStates must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    compliance_state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.compliance_state]
}
