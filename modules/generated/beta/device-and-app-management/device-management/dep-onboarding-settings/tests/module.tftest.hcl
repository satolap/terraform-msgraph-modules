# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/depOnboardingSettings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appleIdentifier", "dataSharingConsentGranted", "defaultIosEnrollmentProfile", "defaultMacOsEnrollmentProfile", "defaultTvOSEnrollmentProfile", "defaultVisionOSEnrollmentProfile", "enrollmentProfiles", "importedAppleDeviceIdentities", "lastModifiedDateTime", "lastSuccessfulSyncDateTime", "lastSyncErrorCode", "lastSyncTriggeredDateTime", "roleScopeTagIds", "shareTokenWithSchoolDataSyncService", "syncedDeviceCount", "tokenExpirationDateTime", "tokenName", "tokenType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    apple_identifier             = "example"
    data_sharing_consent_granted = false
    last_sync_error_code         = -2147483648
    enrollment_profiles          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appleIdentifier"]) == jsonencode("example")
    error_message = "appleIdentifier must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dataSharingConsentGranted"]) == jsonencode(false)
    error_message = "dataSharingConsentGranted must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastSyncErrorCode"]) == jsonencode(-2147483648)
    error_message = "lastSyncErrorCode must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enrollmentProfiles"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.enrollmentProfile" }])
    error_message = "enrollmentProfiles must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    token_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.token_type]
}
