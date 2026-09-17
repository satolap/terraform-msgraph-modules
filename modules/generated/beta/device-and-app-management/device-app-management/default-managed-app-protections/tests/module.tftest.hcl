# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/defaultManagedAppProtections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowWidgetContentSync", "allowedAndroidDeviceManufacturers", "allowedAndroidDeviceModels", "allowedDataIngestionLocations", "allowedDataStorageLocations", "allowedInboundDataTransferSources", "allowedIosDeviceModels", "allowedOutboundClipboardSharingExceptionLength", "allowedOutboundClipboardSharingLevel", "allowedOutboundDataTransferDestinations", "appActionIfAccountIsClockedOut", "appActionIfAndroidDeviceManufacturerNotAllowed", "appActionIfAndroidDeviceModelNotAllowed", "appActionIfAndroidSafetyNetAppsVerificationFailed", "appActionIfAndroidSafetyNetDeviceAttestationFailed", "appActionIfDeviceComplianceRequired", "appActionIfDeviceLockNotSet", "appActionIfDevicePasscodeComplexityLessThanHigh", "appActionIfDevicePasscodeComplexityLessThanLow", "appActionIfDevicePasscodeComplexityLessThanMedium", "appActionIfIosDeviceModelNotAllowed", "appActionIfMaximumPinRetriesExceeded", "appActionIfUnableToAuthenticateUser", "appDataEncryptionType", "apps", "biometricAuthenticationBlocked", "blockAfterCompanyPortalUpdateDeferralInDays", "blockDataIngestionIntoOrganizationDocuments", "connectToVpnOnLaunch", "contactSyncBlocked", "createdDateTime", "customBrowserDisplayName", "customBrowserPackageId", "customBrowserProtocol", "customDialerAppDisplayName", "customDialerAppPackageId", "customDialerAppProtocol", "customSettings", "dataBackupBlocked", "deployedAppCount", "deploymentSummary", "description", "deviceComplianceRequired", "deviceLockRequired", "dialerRestrictionLevel", "disableAppEncryptionIfDeviceEncryptionIsEnabled", "disableAppPinIfDevicePinIsSet", "disableProtectionOfManagedOutboundOpenInData", "displayName", "encryptAppData", "exemptedAppPackages", "exemptedAppProtocols", "faceIdBlocked", "filterOpenInToOnlyManagedApps", "fingerprintAndBiometricEnabled", "fingerprintBlocked", "gracePeriodToBlockAppsDuringOffClockHours", "version", "lastModifiedDateTime", "managedBrowser", "managedBrowserToOpenLinksRequired", "maximumAllowedDeviceThreatLevel", "maximumPinRetries", "maximumRequiredOsVersion", "maximumWarningOsVersion", "maximumWipeOsVersion", "messagingRedirectAppDisplayName", "messagingRedirectAppPackageId", "messagingRedirectAppUrlScheme", "minimumPinLength", "minimumRequiredAppVersion", "minimumRequiredCompanyPortalVersion", "minimumRequiredOsVersion", "minimumRequiredPatchVersion", "minimumRequiredSdkVersion", "minimumWarningAppVersion", "minimumWarningCompanyPortalVersion", "minimumWarningOsVersion", "minimumWarningPatchVersion", "minimumWarningSdkVersion", "minimumWipeAppVersion", "minimumWipeCompanyPortalVersion", "minimumWipeOsVersion", "minimumWipePatchVersion", "minimumWipeSdkVersion", "mobileThreatDefensePartnerPriority", "mobileThreatDefenseRemediationAction", "notificationRestriction", "organizationalCredentialsRequired", "periodBeforePinReset", "periodOfflineBeforeAccessCheck", "periodOfflineBeforeWipeIsEnforced", "periodOnlineBeforeAccessCheck", "pinCharacterSet", "pinRequired", "pinRequiredInsteadOfBiometricTimeout", "previousPinBlockCount", "printBlocked", "protectInboundDataFromUnknownSources", "protectedMessagingRedirectAppType", "purviewContentEvaluationRequired", "requireClass3Biometrics", "requirePinAfterBiometricChange", "requiredAndroidSafetyNetAppsVerificationType", "requiredAndroidSafetyNetDeviceAttestationType", "requiredAndroidSafetyNetEvaluationType", "roleScopeTagIds", "saveAsBlocked", "screenCaptureBlocked", "simplePinBlocked", "thirdPartyKeyboardsBlocked", "warnAfterCompanyPortalUpdateDeferralInDays", "wipeAfterCompanyPortalUpdateDeferralInDays"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowed_android_device_manufacturers                = "example"
    allow_widget_content_sync                           = false
    allowed_outbound_clipboard_sharing_exception_length = -2147483648
    allowed_android_device_models                       = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedAndroidDeviceManufacturers"]) == jsonencode("example")
    error_message = "allowedAndroidDeviceManufacturers must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowWidgetContentSync"]) == jsonencode(false)
    error_message = "allowWidgetContentSync must preserve typed values and omit nested nulls."
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
