# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/mobileThreatDefenseConnectors"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowPartnerToCollectIOSApplicationMetadata", "allowPartnerToCollectIosCertificateMetadata", "allowPartnerToCollectIOSPersonalApplicationMetadata", "allowPartnerToCollectIosPersonalCertificateMetadata", "androidDeviceBlockedOnMissingPartnerData", "androidEnabled", "androidMobileApplicationManagementEnabled", "grantMobileThreatDefensePartnerRole", "iosDeviceBlockedOnMissingPartnerData", "iosEnabled", "iosMobileApplicationManagementEnabled", "lastHeartbeatDateTime", "launchMobileThreatDefensePartnerOnSetupEnabled", "macDeviceBlockedOnMissingPartnerData", "macEnabled", "microsoftDefenderForEndpointAttachEnabled", "partnerMinimumSupportedAndroidVersion", "partnerMinimumSupportedIosVersion", "partnerMinimumSupportedMacVersion", "partnerMinimumSupportedWindowsVersion", "partnerState", "partnerSupportsAndroidMam", "partnerSupportsIosCertificateSync", "partnerSupportsIosMam", "partnerSupportsWindowsMam", "partnerUnresponsivenessThresholdInDays", "partnerUnsupportedOsVersionBlocked", "windowsDeviceBlockedOnMissingPartnerData", "windowsEnabled", "windowsMobileApplicationManagementEnabled"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    last_heartbeat_date_time                          = "2026-01-01T00:00:00Z"
    allow_partner_to_collect_ios_application_metadata = false
    partner_unresponsiveness_threshold_in_days        = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastHeartbeatDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastHeartbeatDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowPartnerToCollectIOSApplicationMetadata"]) == jsonencode(false)
    error_message = "allowPartnerToCollectIOSApplicationMetadata must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["partnerUnresponsivenessThresholdInDays"]) == jsonencode(-2147483648)
    error_message = "partnerUnresponsivenessThresholdInDays must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    partner_state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.partner_state]
}
