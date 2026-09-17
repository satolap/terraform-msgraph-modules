# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    windows_autopilot_deployment_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsAutopilotDeploymentProfiles/test-parent-id/assignedDevices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["addressableUserName", "azureActiveDirectoryDeviceId", "azureAdDeviceId", "deploymentProfile", "deploymentProfileAssignedDateTime", "deploymentProfileAssignmentDetailedStatus", "deploymentProfileAssignmentStatus", "deviceAccountPassword", "deviceAccountUpn", "deviceFriendlyName", "displayName", "enrollmentState", "groupTag", "intendedDeploymentProfile", "lastContactedDateTime", "managedDeviceId", "manufacturer", "model", "productKey", "purchaseOrderIdentifier", "remediationState", "remediationStateLastModifiedDateTime", "resourceName", "serialNumber", "skuNumber", "systemFamily", "userPrincipalName", "userlessEnrollmentStatus"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    windows_autopilot_deployment_profile_id = "test-parent-id"
    addressable_user_name                   = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["addressableUserName"]) == jsonencode("example")
    error_message = "addressableUserName must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    windows_autopilot_deployment_profile_id       = "test-parent-id"
    deployment_profile_assignment_detailed_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.deployment_profile_assignment_detailed_status]
}
