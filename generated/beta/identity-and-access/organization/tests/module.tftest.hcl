# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "organization"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedPlans", "branding", "businessPhones", "certificateBasedAuthConfiguration", "certificateConnectorSetting", "city", "country", "countryLetterCode", "defaultUsageLocation", "deletedDateTime", "directorySizeQuota", "displayName", "extensions", "marketingNotificationEmails", "mobileDeviceManagementAuthority", "onPremisesLastPasswordSyncDateTime", "onPremisesLastSyncDateTime", "onPremisesSyncEnabled", "partnerInformation", "partnerTenantType", "postalCode", "preferredLanguage", "privacyProfile", "provisionedPlans", "resourceQuotas", "securityComplianceNotificationMails", "securityComplianceNotificationPhones", "settings", "state", "street", "technicalNotificationMails", "tenantType", "verifiedDomains"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    city                     = "example"
    on_premises_sync_enabled = false
    assigned_plans           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["city"]) == jsonencode("example")
    error_message = "city must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["onPremisesSyncEnabled"]) == jsonencode(false)
    error_message = "onPremisesSyncEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedPlans"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.assignedPlan" }])
    error_message = "assignedPlans must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    mobile_device_management_authority = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.mobile_device_management_authority]
}
