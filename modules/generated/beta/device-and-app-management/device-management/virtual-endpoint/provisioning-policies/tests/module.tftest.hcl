# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/provisioningPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "autopatch", "autopilotConfiguration", "cloudPcNamingTemplate", "description", "displayName", "domainJoinConfigurations", "enableSingleSignOn", "imageDisplayName", "imageId", "imageType", "localAdminEnabled", "managedBy", "microsoftManagedDesktop", "provisioningType", "snapshotResetMode", "userExperienceType", "userSettingsPersistenceConfiguration", "windowsSetting", "windowsSettings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    cloud_pc_naming_template = "example"
    enable_single_sign_on    = false
    assignments              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["cloudPcNamingTemplate"]) == jsonencode("example")
    error_message = "cloudPcNamingTemplate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enableSingleSignOn"]) == jsonencode(false)
    error_message = "enableSingleSignOn must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.cloudPcProvisioningPolicyAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    image_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.image_type]
}
