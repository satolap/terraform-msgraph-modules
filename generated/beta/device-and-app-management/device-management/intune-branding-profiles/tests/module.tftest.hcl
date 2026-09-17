# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/intuneBrandingProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "companyPortalBlockedActions", "contactITEmailAddress", "contactITName", "contactITNotes", "contactITPhoneNumber", "createdDateTime", "customCanSeePrivacyMessage", "customCantSeePrivacyMessage", "customPrivacyMessage", "disableClientTelemetry", "disableDeviceCategorySelection", "displayName", "enrollmentAvailability", "isDefaultProfile", "isFactoryResetDisabled", "isRemoveDeviceDisabled", "landingPageCustomizedImage", "lastModifiedDateTime", "lightBackgroundLogo", "onlineSupportSiteName", "onlineSupportSiteUrl", "privacyUrl", "profileDescription", "profileName", "roleScopeTagIds", "showAzureADEnterpriseApps", "showConfigurationManagerApps", "showDisplayNameNextToLogo", "showLogo", "showOfficeWebApps", "themeColor", "themeColorLogo"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    contact_it_email_address = "example"
    disable_client_telemetry = false
    assignments              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contactITEmailAddress"]) == jsonencode("example")
    error_message = "contactITEmailAddress must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["disableClientTelemetry"]) == jsonencode(false)
    error_message = "disableClientTelemetry must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.intuneBrandingProfileAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    enrollment_availability = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.enrollment_availability]
}
