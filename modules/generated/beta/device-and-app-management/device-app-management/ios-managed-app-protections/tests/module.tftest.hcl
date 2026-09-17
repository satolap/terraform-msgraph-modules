# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/iosManagedAppProtections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowWidgetContentSync", "allowedDataIngestionLocations", "allowedDataStorageLocations", "allowedInboundDataTransferSources", "allowedIosDeviceModels", "allowedOutboundClipboardSharingExceptionLength", "allowedOutboundClipboardSharingLevel", "allowedOutboundDataTransferDestinations", "appActionIfAccountIsClockedOut", "appActionIfDeviceComplianceRequired", "appActionIfIosDeviceModelNotAllowed", "appActionIfMaximumPinRetriesExceeded", "appActionIfUnableToAuthenticateUser", "appDataEncryptionType", "appGroupType", "apps", "assignments", "blockDataIngestionIntoOrganizationDocuments", "contactSyncBlocked", "createdDateTime", "customBrowserProtocol", "customDialerAppProtocol", "dataBackupBlocked", "deployedAppCount", "deploymentSummary", "description", "deviceComplianceRequired", "dialerRestrictionLevel", "disableAppPinIfDevicePinIsSet", "disableProtectionOfManagedOutboundOpenInData", "displayName", "exemptedAppProtocols", "exemptedUniversalLinks", "faceIdBlocked", "filterOpenInToOnlyManagedApps", "fingerprintBlocked", "genmojiConfigurationState", "gracePeriodToBlockAppsDuringOffClockHours", "version", "isAssigned", "lastModifiedDateTime", "managedBrowser", "managedBrowserToOpenLinksRequired", "managedUniversalLinks", "maximumAllowedDeviceThreatLevel", "maximumPinRetries", "maximumRequiredOsVersion", "maximumWarningOsVersion", "maximumWipeOsVersion", "messagingRedirectAppUrlScheme", "minimumPinLength", "minimumRequiredAppVersion", "minimumRequiredOsVersion", "minimumRequiredSdkVersion", "minimumWarningAppVersion", "minimumWarningOsVersion", "minimumWarningSdkVersion", "minimumWipeAppVersion", "minimumWipeOsVersion", "minimumWipeSdkVersion", "mobileThreatDefensePartnerPriority", "mobileThreatDefenseRemediationAction", "notificationRestriction", "organizationalCredentialsRequired", "periodBeforePinReset", "periodOfflineBeforeAccessCheck", "periodOfflineBeforeWipeIsEnforced", "periodOnlineBeforeAccessCheck", "pinCharacterSet", "pinRequired", "pinRequiredInsteadOfBiometricTimeout", "previousPinBlockCount", "printBlocked", "protectInboundDataFromUnknownSources", "protectedMessagingRedirectAppType", "purviewContentEvaluationRequired", "roleScopeTagIds", "saveAsBlocked", "screenCaptureConfigurationState", "simplePinBlocked", "targetedAppManagementLevels", "thirdPartyKeyboardsBlocked", "writingToolsConfigurationState"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowed_inbound_data_transfer_sources               = "allApps"
    allow_widget_content_sync                           = false
    allowed_outbound_clipboard_sharing_exception_length = -2147483648
    allowed_data_ingestion_locations                    = ["oneDriveForBusiness"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedInboundDataTransferSources"]) == jsonencode("allApps")
    error_message = "allowedInboundDataTransferSources must preserve typed values and omit nested nulls."
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
    condition     = jsonencode(msgraph_resource.this.body["allowedDataIngestionLocations"]) == jsonencode(["oneDriveForBusiness"])
    error_message = "allowedDataIngestionLocations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allowed_inbound_data_transfer_sources = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_inbound_data_transfer_sources]
}
