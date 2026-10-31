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
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "assignments", "deploymentSummary"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowedInboundDataTransferSources              = "allApps"
    allowWidgetContentSync                         = false
    allowedOutboundClipboardSharingExceptionLength = -2147483648
    allowedDataIngestionLocations                  = ["oneDriveForBusiness"]
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
    allowedInboundDataTransferSources = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowedInboundDataTransferSources]
}

run "flags_enum_combination" {
  command = plan

  variables {
    managedBrowser              = "notConfigured, MicrosoftEdge"
    targetedAppManagementLevels = "unspecified, Unmanaged"
  }

  assert {
    condition     = msgraph_resource.this.body["managedBrowser"] == "notConfigured, MicrosoftEdge"
    error_message = "managedBrowser must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["targetedAppManagementLevels"] == "unspecified, Unmanaged"
    error_message = "targetedAppManagementLevels must accept combined flags enum members."
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
