# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/cloudPCs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["aadDeviceId", "connectivityResult", "diskEncryptionState", "displayName", "gracePeriodEndDateTime", "imageDisplayName", "lastLoginResult", "lastModifiedDateTime", "lastRemoteActionResult", "managedDeviceId", "managedDeviceName", "onPremisesConnectionName", "osVersion", "partnerAgentInstallResults", "powerState", "provisionedDateTime", "provisioningPolicyId", "provisioningPolicyName", "provisioningType", "servicePlanId", "servicePlanName", "servicePlanType", "sharedDeviceDetail", "status", "statusDetail", "statusDetails", "userAccountType", "userExperienceType", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    aad_device_id                 = "example"
    partner_agent_install_results = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["aadDeviceId"]) == jsonencode("example")
    error_message = "aadDeviceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["partnerAgentInstallResults"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.cloudPcPartnerAgentInstallResult" }])
    error_message = "partnerAgentInstallResults must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    disk_encryption_state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.disk_encryption_state]
}
