# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowWidgetContentSync"                             = var.allowWidgetContentSync
    "allowedAndroidDeviceManufacturers"                  = var.allowedAndroidDeviceManufacturers
    "allowedAndroidDeviceModels"                         = (var.allowedAndroidDeviceModels == null ? null : [for item0 in var.allowedAndroidDeviceModels : item0 if item0 != null])
    "allowedDataIngestionLocations"                      = (var.allowedDataIngestionLocations == null ? null : [for item0 in var.allowedDataIngestionLocations : item0 if item0 != null])
    "allowedDataStorageLocations"                        = (var.allowedDataStorageLocations == null ? null : [for item0 in var.allowedDataStorageLocations : item0 if item0 != null])
    "allowedInboundDataTransferSources"                  = var.allowedInboundDataTransferSources
    "allowedIosDeviceModels"                             = var.allowedIosDeviceModels
    "allowedOutboundClipboardSharingExceptionLength"     = var.allowedOutboundClipboardSharingExceptionLength
    "allowedOutboundClipboardSharingLevel"               = var.allowedOutboundClipboardSharingLevel
    "allowedOutboundDataTransferDestinations"            = var.allowedOutboundDataTransferDestinations
    "appActionIfAccountIsClockedOut"                     = var.appActionIfAccountIsClockedOut
    "appActionIfAndroidDeviceManufacturerNotAllowed"     = var.appActionIfAndroidDeviceManufacturerNotAllowed
    "appActionIfAndroidDeviceModelNotAllowed"            = var.appActionIfAndroidDeviceModelNotAllowed
    "appActionIfAndroidSafetyNetAppsVerificationFailed"  = var.appActionIfAndroidSafetyNetAppsVerificationFailed
    "appActionIfAndroidSafetyNetDeviceAttestationFailed" = var.appActionIfAndroidSafetyNetDeviceAttestationFailed
    "appActionIfDeviceComplianceRequired"                = var.appActionIfDeviceComplianceRequired
    "appActionIfDeviceLockNotSet"                        = var.appActionIfDeviceLockNotSet
    "appActionIfDevicePasscodeComplexityLessThanHigh"    = var.appActionIfDevicePasscodeComplexityLessThanHigh
    "appActionIfDevicePasscodeComplexityLessThanLow"     = var.appActionIfDevicePasscodeComplexityLessThanLow
    "appActionIfDevicePasscodeComplexityLessThanMedium"  = var.appActionIfDevicePasscodeComplexityLessThanMedium
    "appActionIfIosDeviceModelNotAllowed"                = var.appActionIfIosDeviceModelNotAllowed
    "appActionIfMaximumPinRetriesExceeded"               = var.appActionIfMaximumPinRetriesExceeded
    "appActionIfUnableToAuthenticateUser"                = var.appActionIfUnableToAuthenticateUser
    "appDataEncryptionType"                              = var.appDataEncryptionType
    "apps"                                               = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "biometricAuthenticationBlocked"                     = var.biometricAuthenticationBlocked
    "blockAfterCompanyPortalUpdateDeferralInDays"        = var.blockAfterCompanyPortalUpdateDeferralInDays
    "blockDataIngestionIntoOrganizationDocuments"        = var.blockDataIngestionIntoOrganizationDocuments
    "connectToVpnOnLaunch"                               = var.connectToVpnOnLaunch
    "contactSyncBlocked"                                 = var.contactSyncBlocked
    "createdDateTime"                                    = var.createdDateTime
    "customBrowserDisplayName"                           = var.customBrowserDisplayName
    "customBrowserPackageId"                             = var.customBrowserPackageId
    "customBrowserProtocol"                              = var.customBrowserProtocol
    "customDialerAppDisplayName"                         = var.customDialerAppDisplayName
    "customDialerAppPackageId"                           = var.customDialerAppPackageId
    "customDialerAppProtocol"                            = var.customDialerAppProtocol
    "customSettings"                                     = (var.customSettings == null ? null : [for item0 in var.customSettings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "dataBackupBlocked"                                  = var.dataBackupBlocked
    "deployedAppCount"                                   = var.deployedAppCount
    "deploymentSummary"                                  = var.deploymentSummary
    "description"                                        = var.description
    "deviceComplianceRequired"                           = var.deviceComplianceRequired
    "deviceLockRequired"                                 = var.deviceLockRequired
    "dialerRestrictionLevel"                             = var.dialerRestrictionLevel
    "disableAppEncryptionIfDeviceEncryptionIsEnabled"    = var.disableAppEncryptionIfDeviceEncryptionIsEnabled
    "disableAppPinIfDevicePinIsSet"                      = var.disableAppPinIfDevicePinIsSet
    "disableProtectionOfManagedOutboundOpenInData"       = var.disableProtectionOfManagedOutboundOpenInData
    "displayName"                                        = var.displayName
    "encryptAppData"                                     = var.encryptAppData
    "exemptedAppPackages"                                = (var.exemptedAppPackages == null ? null : [for item0 in var.exemptedAppPackages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "exemptedAppProtocols"                               = (var.exemptedAppProtocols == null ? null : [for item0 in var.exemptedAppProtocols : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "faceIdBlocked"                                      = var.faceIdBlocked
    "filterOpenInToOnlyManagedApps"                      = var.filterOpenInToOnlyManagedApps
    "fingerprintAndBiometricEnabled"                     = var.fingerprintAndBiometricEnabled
    "fingerprintBlocked"                                 = var.fingerprintBlocked
    "gracePeriodToBlockAppsDuringOffClockHours"          = var.gracePeriodToBlockAppsDuringOffClockHours
    "version"                                            = var.graph_version
    "lastModifiedDateTime"                               = var.lastModifiedDateTime
    "managedBrowser"                                     = var.managedBrowser
    "managedBrowserToOpenLinksRequired"                  = var.managedBrowserToOpenLinksRequired
    "maximumAllowedDeviceThreatLevel"                    = var.maximumAllowedDeviceThreatLevel
    "maximumPinRetries"                                  = var.maximumPinRetries
    "maximumRequiredOsVersion"                           = var.maximumRequiredOsVersion
    "maximumWarningOsVersion"                            = var.maximumWarningOsVersion
    "maximumWipeOsVersion"                               = var.maximumWipeOsVersion
    "messagingRedirectAppDisplayName"                    = var.messagingRedirectAppDisplayName
    "messagingRedirectAppPackageId"                      = var.messagingRedirectAppPackageId
    "messagingRedirectAppUrlScheme"                      = var.messagingRedirectAppUrlScheme
    "minimumPinLength"                                   = var.minimumPinLength
    "minimumRequiredAppVersion"                          = var.minimumRequiredAppVersion
    "minimumRequiredCompanyPortalVersion"                = var.minimumRequiredCompanyPortalVersion
    "minimumRequiredOsVersion"                           = var.minimumRequiredOsVersion
    "minimumRequiredPatchVersion"                        = var.minimumRequiredPatchVersion
    "minimumRequiredSdkVersion"                          = var.minimumRequiredSdkVersion
    "minimumWarningAppVersion"                           = var.minimumWarningAppVersion
    "minimumWarningCompanyPortalVersion"                 = var.minimumWarningCompanyPortalVersion
    "minimumWarningOsVersion"                            = var.minimumWarningOsVersion
    "minimumWarningPatchVersion"                         = var.minimumWarningPatchVersion
    "minimumWarningSdkVersion"                           = var.minimumWarningSdkVersion
    "minimumWipeAppVersion"                              = var.minimumWipeAppVersion
    "minimumWipeCompanyPortalVersion"                    = var.minimumWipeCompanyPortalVersion
    "minimumWipeOsVersion"                               = var.minimumWipeOsVersion
    "minimumWipePatchVersion"                            = var.minimumWipePatchVersion
    "minimumWipeSdkVersion"                              = var.minimumWipeSdkVersion
    "mobileThreatDefensePartnerPriority"                 = var.mobileThreatDefensePartnerPriority
    "mobileThreatDefenseRemediationAction"               = var.mobileThreatDefenseRemediationAction
    "notificationRestriction"                            = var.notificationRestriction
    "@odata.type"                                        = var.odata_type
    "organizationalCredentialsRequired"                  = var.organizationalCredentialsRequired
    "periodBeforePinReset"                               = var.periodBeforePinReset
    "periodOfflineBeforeAccessCheck"                     = var.periodOfflineBeforeAccessCheck
    "periodOfflineBeforeWipeIsEnforced"                  = var.periodOfflineBeforeWipeIsEnforced
    "periodOnlineBeforeAccessCheck"                      = var.periodOnlineBeforeAccessCheck
    "pinCharacterSet"                                    = var.pinCharacterSet
    "pinRequired"                                        = var.pinRequired
    "pinRequiredInsteadOfBiometricTimeout"               = var.pinRequiredInsteadOfBiometricTimeout
    "previousPinBlockCount"                              = var.previousPinBlockCount
    "printBlocked"                                       = var.printBlocked
    "protectInboundDataFromUnknownSources"               = var.protectInboundDataFromUnknownSources
    "protectedMessagingRedirectAppType"                  = var.protectedMessagingRedirectAppType
    "purviewContentEvaluationRequired"                   = var.purviewContentEvaluationRequired
    "requireClass3Biometrics"                            = var.requireClass3Biometrics
    "requirePinAfterBiometricChange"                     = var.requirePinAfterBiometricChange
    "requiredAndroidSafetyNetAppsVerificationType"       = var.requiredAndroidSafetyNetAppsVerificationType
    "requiredAndroidSafetyNetDeviceAttestationType"      = var.requiredAndroidSafetyNetDeviceAttestationType
    "requiredAndroidSafetyNetEvaluationType"             = var.requiredAndroidSafetyNetEvaluationType
    "roleScopeTagIds"                                    = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "saveAsBlocked"                                      = var.saveAsBlocked
    "screenCaptureBlocked"                               = var.screenCaptureBlocked
    "simplePinBlocked"                                   = var.simplePinBlocked
    "thirdPartyKeyboardsBlocked"                         = var.thirdPartyKeyboardsBlocked
    "warnAfterCompanyPortalUpdateDeferralInDays"         = var.warnAfterCompanyPortalUpdateDeferralInDays
    "wipeAfterCompanyPortalUpdateDeferralInDays"         = var.wipeAfterCompanyPortalUpdateDeferralInDays
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/defaultManagedAppProtections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "deploymentSummary"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
