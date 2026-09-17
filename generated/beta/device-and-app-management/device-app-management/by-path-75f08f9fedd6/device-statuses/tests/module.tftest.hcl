# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    windows_defender_application_control_supplemental_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/wdacSupplementalPolicies/test-parent-id/deviceStatuses"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deploymentStatus", "deviceId", "deviceName", "lastSyncDateTime", "osDescription", "osVersion", "policy", "policyVersion", "userName", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    windows_defender_application_control_supplemental_policy_id = "test-parent-id"
    deployment_status                                           = "unknown"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deploymentStatus"]) == jsonencode("unknown")
    error_message = "deploymentStatus must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    windows_defender_application_control_supplemental_policy_id = "test-parent-id"
    deployment_status                                           = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.deployment_status]
}
