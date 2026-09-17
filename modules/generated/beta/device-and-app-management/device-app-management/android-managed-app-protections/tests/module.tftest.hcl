# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/androidManagedAppProtections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedAndroidDeviceManufacturers", "allowedAndroidDeviceModels", "allowedDataIngestionLocations", "allowedDataStorageLocations", "allowedInboundDataTransferSources", "allowedOutboundClipboardSharingExceptionLength", "allowedOutboundClipboardSharingLevel", "allowedOutboundDataTransferDestinations", "appActionIfAccountIsClockedOut", "appActionIfAndroidDeviceManufacturerNotAllowed", "appActionIfAndroidDeviceModelNotAllowed", "appActionIfAndroidSafetyNetAppsVerificationFailed", "appActionIfAndroidSafetyNetDeviceAttestationFailed", "appActionIfDeveloperOptionsEnabled", "appActionIfDeviceComplianceRequired", "appActionIfDeviceLockNotSet", "appActionIfDevicePasscodeComplexityLessThanHigh", "appActionIfDevicePasscodeComplexityLessThanLow", "appActionIfDevicePasscodeComplexityLessThanMedium", "appActionIfMaximumPinRetriesExceeded", "appActionIfSamsungKnoxAttestationRequired", "appActionIfUnableToAuthenticateUser", "appGroupType", "approvedKeyboards", "apps", "assignments", "biometricAuthenticationBlocked", "blockAfterCompanyPortalUpdateDeferralInDays", "blockDataIngestionIntoOrganizationDocuments", "connectToVpnOnLaunch", "contactSyncBlocked", "createdDateTime", "customBrowserDisplayName", "customBrowserPackageId", "customDialerAppDisplayName", "customDialerAppPackageId", "dataBackupBlocked", "deployedAppCount", "deploymentSummary", "description", "deviceComplianceRequired", "deviceLockRequired", "dialerRestrictionLevel", "disableAppEncryptionIfDeviceEncryptionIsEnabled", "disableAppPinIfDevicePinIsSet", "displayName", "encryptAppData", "exemptedAppPackages", "fingerprintAndBiometricEnabled", "fingerprintBlocked", "gracePeriodToBlockAppsDuringOffClockHours", "version", "isAssigned", "keyboardsRestricted", "lastModifiedDateTime", "managedBrowser", "managedBrowserToOpenLinksRequired", "maximumAllowedDeviceThreatLevel", "maximumPinRetries", "maximumRequiredOsVersion", "maximumWarningOsVersion", "maximumWipeOsVersion", "messagingRedirectAppDisplayName", "messagingRedirectAppPackageId", "minimumPinLength", "minimumRequiredAppVersion", "minimumRequiredCompanyPortalVersion", "minimumRequiredOsVersion", "minimumRequiredPatchVersion", "minimumWarningAppVersion", "minimumWarningCompanyPortalVersion", "minimumWarningOsVersion", "minimumWarningPatchVersion", "minimumWipeAppVersion", "minimumWipeCompanyPortalVersion", "minimumWipeOsVersion", "minimumWipePatchVersion", "mobileThreatDefensePartnerPriority", "mobileThreatDefenseRemediationAction", "notificationRestriction", "organizationalCredentialsRequired", "periodBeforePinReset", "periodOfflineBeforeAccessCheck", "periodOfflineBeforeWipeIsEnforced", "periodOnlineBeforeAccessCheck", "pinCharacterSet", "pinRequired", "pinRequiredInsteadOfBiometricTimeout", "previousPinBlockCount", "printBlocked", "protectedMessagingRedirectAppType", "purviewContentEvaluationRequired", "requireClass3Biometrics", "requirePinAfterBiometricChange", "requiredAndroidSafetyNetAppsVerificationType", "requiredAndroidSafetyNetDeviceAttestationType", "requiredAndroidSafetyNetEvaluationType", "roleScopeTagIds", "saveAsBlocked", "screenCaptureBlocked", "simplePinBlocked", "targetedAppManagementLevels", "warnAfterCompanyPortalUpdateDeferralInDays", "wipeAfterCompanyPortalUpdateDeferralInDays"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowed_android_device_manufacturers                = "example"
    biometric_authentication_blocked                    = false
    allowed_outbound_clipboard_sharing_exception_length = -2147483648
    allowed_android_device_models                       = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedAndroidDeviceManufacturers"]) == jsonencode("example")
    error_message = "allowedAndroidDeviceManufacturers must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["biometricAuthenticationBlocked"]) == jsonencode(false)
    error_message = "biometricAuthenticationBlocked must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedOutboundClipboardSharingExceptionLength"]) == jsonencode(-2147483648)
    error_message = "allowedOutboundClipboardSharingExceptionLength must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedAndroidDeviceModels"]) == jsonencode(["example"])
    error_message = "allowedAndroidDeviceModels must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allowed_inbound_data_transfer_sources = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_inbound_data_transfer_sources]
}
