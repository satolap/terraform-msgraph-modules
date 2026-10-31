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

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "deploymentSummary"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowedAndroidDeviceManufacturers              = "example"
    allowWidgetContentSync                         = false
    allowedOutboundClipboardSharingExceptionLength = -2147483648
    allowedAndroidDeviceModels                     = ["example"]
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
    allowedInboundDataTransferSources = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowedInboundDataTransferSources]
}

run "flags_enum_combination" {
  command = plan

  variables {
    managedBrowser = "notConfigured, MicrosoftEdge"
  }

  assert {
    condition     = msgraph_resource.this.body["managedBrowser"] == "notConfigured, MicrosoftEdge"
    error_message = "managedBrowser must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    managedBrowser = "notConfigured,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.managedBrowser]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    timeouts = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    timeouts = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    timeouts = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    timeouts = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
