# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowWidgetContentSync"                         = var.allowWidgetContentSync
    "allowedDataIngestionLocations"                  = (var.allowedDataIngestionLocations == null ? null : [for item0 in var.allowedDataIngestionLocations : item0 if item0 != null])
    "allowedDataStorageLocations"                    = (var.allowedDataStorageLocations == null ? null : [for item0 in var.allowedDataStorageLocations : item0 if item0 != null])
    "allowedInboundDataTransferSources"              = var.allowedInboundDataTransferSources
    "allowedIosDeviceModels"                         = var.allowedIosDeviceModels
    "allowedOutboundClipboardSharingExceptionLength" = var.allowedOutboundClipboardSharingExceptionLength
    "allowedOutboundClipboardSharingLevel"           = var.allowedOutboundClipboardSharingLevel
    "allowedOutboundDataTransferDestinations"        = var.allowedOutboundDataTransferDestinations
    "appActionIfAccountIsClockedOut"                 = var.appActionIfAccountIsClockedOut
    "appActionIfDeviceComplianceRequired"            = var.appActionIfDeviceComplianceRequired
    "appActionIfIosDeviceModelNotAllowed"            = var.appActionIfIosDeviceModelNotAllowed
    "appActionIfMaximumPinRetriesExceeded"           = var.appActionIfMaximumPinRetriesExceeded
    "appActionIfUnableToAuthenticateUser"            = var.appActionIfUnableToAuthenticateUser
    "appDataEncryptionType"                          = var.appDataEncryptionType
    "appGroupType"                                   = var.appGroupType
    "apps"                                           = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                                    = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "blockDataIngestionIntoOrganizationDocuments"    = var.blockDataIngestionIntoOrganizationDocuments
    "contactSyncBlocked"                             = var.contactSyncBlocked
    "createdDateTime"                                = var.createdDateTime
    "customBrowserProtocol"                          = var.customBrowserProtocol
    "customDialerAppProtocol"                        = var.customDialerAppProtocol
    "dataBackupBlocked"                              = var.dataBackupBlocked
    "deployedAppCount"                               = var.deployedAppCount
    "deploymentSummary"                              = var.deploymentSummary
    "description"                                    = var.description
    "deviceComplianceRequired"                       = var.deviceComplianceRequired
    "dialerRestrictionLevel"                         = var.dialerRestrictionLevel
    "disableAppPinIfDevicePinIsSet"                  = var.disableAppPinIfDevicePinIsSet
    "disableProtectionOfManagedOutboundOpenInData"   = var.disableProtectionOfManagedOutboundOpenInData
    "displayName"                                    = var.displayName
    "exemptedAppProtocols"                           = (var.exemptedAppProtocols == null ? null : [for item0 in var.exemptedAppProtocols : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "exemptedUniversalLinks"                         = (var.exemptedUniversalLinks == null ? null : [for item0 in var.exemptedUniversalLinks : item0 if item0 != null])
    "faceIdBlocked"                                  = var.faceIdBlocked
    "filterOpenInToOnlyManagedApps"                  = var.filterOpenInToOnlyManagedApps
    "fingerprintBlocked"                             = var.fingerprintBlocked
    "genmojiConfigurationState"                      = var.genmojiConfigurationState
    "gracePeriodToBlockAppsDuringOffClockHours"      = var.gracePeriodToBlockAppsDuringOffClockHours
    "version"                                        = var.graph_version
    "isAssigned"                                     = var.isAssigned
    "lastModifiedDateTime"                           = var.lastModifiedDateTime
    "managedBrowser"                                 = var.managedBrowser
    "managedBrowserToOpenLinksRequired"              = var.managedBrowserToOpenLinksRequired
    "managedUniversalLinks"                          = (var.managedUniversalLinks == null ? null : [for item0 in var.managedUniversalLinks : item0 if item0 != null])
    "maximumAllowedDeviceThreatLevel"                = var.maximumAllowedDeviceThreatLevel
    "maximumPinRetries"                              = var.maximumPinRetries
    "maximumRequiredOsVersion"                       = var.maximumRequiredOsVersion
    "maximumWarningOsVersion"                        = var.maximumWarningOsVersion
    "maximumWipeOsVersion"                           = var.maximumWipeOsVersion
    "messagingRedirectAppUrlScheme"                  = var.messagingRedirectAppUrlScheme
    "minimumPinLength"                               = var.minimumPinLength
    "minimumRequiredAppVersion"                      = var.minimumRequiredAppVersion
    "minimumRequiredOsVersion"                       = var.minimumRequiredOsVersion
    "minimumRequiredSdkVersion"                      = var.minimumRequiredSdkVersion
    "minimumWarningAppVersion"                       = var.minimumWarningAppVersion
    "minimumWarningOsVersion"                        = var.minimumWarningOsVersion
    "minimumWarningSdkVersion"                       = var.minimumWarningSdkVersion
    "minimumWipeAppVersion"                          = var.minimumWipeAppVersion
    "minimumWipeOsVersion"                           = var.minimumWipeOsVersion
    "minimumWipeSdkVersion"                          = var.minimumWipeSdkVersion
    "mobileThreatDefensePartnerPriority"             = var.mobileThreatDefensePartnerPriority
    "mobileThreatDefenseRemediationAction"           = var.mobileThreatDefenseRemediationAction
    "notificationRestriction"                        = var.notificationRestriction
    "@odata.type"                                    = var.odata_type
    "organizationalCredentialsRequired"              = var.organizationalCredentialsRequired
    "periodBeforePinReset"                           = var.periodBeforePinReset
    "periodOfflineBeforeAccessCheck"                 = var.periodOfflineBeforeAccessCheck
    "periodOfflineBeforeWipeIsEnforced"              = var.periodOfflineBeforeWipeIsEnforced
    "periodOnlineBeforeAccessCheck"                  = var.periodOnlineBeforeAccessCheck
    "pinCharacterSet"                                = var.pinCharacterSet
    "pinRequired"                                    = var.pinRequired
    "pinRequiredInsteadOfBiometricTimeout"           = var.pinRequiredInsteadOfBiometricTimeout
    "previousPinBlockCount"                          = var.previousPinBlockCount
    "printBlocked"                                   = var.printBlocked
    "protectInboundDataFromUnknownSources"           = var.protectInboundDataFromUnknownSources
    "protectedMessagingRedirectAppType"              = var.protectedMessagingRedirectAppType
    "purviewContentEvaluationRequired"               = var.purviewContentEvaluationRequired
    "roleScopeTagIds"                                = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "saveAsBlocked"                                  = var.saveAsBlocked
    "screenCaptureConfigurationState"                = var.screenCaptureConfigurationState
    "simplePinBlocked"                               = var.simplePinBlocked
    "targetedAppManagementLevels"                    = var.targetedAppManagementLevels
    "thirdPartyKeyboardsBlocked"                     = var.thirdPartyKeyboardsBlocked
    "writingToolsConfigurationState"                 = var.writingToolsConfigurationState
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/iosManagedAppProtections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "assignments", "deploymentSummary"], name)])]))))] } : null

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
