# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/managedDevices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignmentFilterEvaluationStatusDetails", "chassisType", "chromeOSDeviceInfo", "cloudPcRemoteActionResults", "complianceState", "configurationManagerClientHealthState", "configurationManagerClientInformation", "detectedApps", "deviceCategory", "deviceCompliancePolicyStates", "deviceConfigurationStates", "deviceEnrollmentType", "deviceFirmwareConfigurationInterfaceManaged", "deviceRegistrationState", "deviceType", "exchangeAccessState", "exchangeAccessStateReason", "joinType", "logCollectionRequests", "lostModeState", "managedDeviceMobileAppConfigurationStates", "managedDeviceName", "managedDeviceOwnerType", "managementAgent", "managementFeatures", "managementState", "notes", "ownerType", "partnerReportedThreatState", "processorArchitecture", "roleScopeTagIds", "securityBaselineStates", "skuFamily", "users"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    chassis_type                                    = "unknown"
    device_firmware_configuration_interface_managed = false
    assignment_filter_evaluation_status_details     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["chassisType"]) == jsonencode("unknown")
    error_message = "chassisType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceFirmwareConfigurationInterfaceManaged"]) == jsonencode(false)
    error_message = "deviceFirmwareConfigurationInterfaceManaged must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentFilterEvaluationStatusDetails"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.assignmentFilterEvaluationStatusDetails" }])
    error_message = "assignmentFilterEvaluationStatusDetails must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    chassis_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.chassis_type]
}
