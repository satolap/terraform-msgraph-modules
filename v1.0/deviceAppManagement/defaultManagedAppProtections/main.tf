# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedDataStorageLocations"                     = (var.allowedDataStorageLocations == null ? null : [for item0 in var.allowedDataStorageLocations : item0 if item0 != null])
    "allowedInboundDataTransferSources"               = var.allowedInboundDataTransferSources
    "allowedOutboundClipboardSharingLevel"            = var.allowedOutboundClipboardSharingLevel
    "allowedOutboundDataTransferDestinations"         = var.allowedOutboundDataTransferDestinations
    "appDataEncryptionType"                           = var.appDataEncryptionType
    "apps"                                            = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "contactSyncBlocked"                              = var.contactSyncBlocked
    "createdDateTime"                                 = var.createdDateTime
    "customSettings"                                  = (var.customSettings == null ? null : [for item0 in var.customSettings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "dataBackupBlocked"                               = var.dataBackupBlocked
    "deployedAppCount"                                = var.deployedAppCount
    "deploymentSummary"                               = var.deploymentSummary
    "description"                                     = var.description
    "deviceComplianceRequired"                        = var.deviceComplianceRequired
    "disableAppEncryptionIfDeviceEncryptionIsEnabled" = var.disableAppEncryptionIfDeviceEncryptionIsEnabled
    "disableAppPinIfDevicePinIsSet"                   = var.disableAppPinIfDevicePinIsSet
    "displayName"                                     = var.displayName
    "encryptAppData"                                  = var.encryptAppData
    "faceIdBlocked"                                   = var.faceIdBlocked
    "fingerprintBlocked"                              = var.fingerprintBlocked
    "version"                                         = var.graph_version
    "lastModifiedDateTime"                            = var.lastModifiedDateTime
    "managedBrowser"                                  = var.managedBrowser
    "managedBrowserToOpenLinksRequired"               = var.managedBrowserToOpenLinksRequired
    "maximumPinRetries"                               = var.maximumPinRetries
    "minimumPinLength"                                = var.minimumPinLength
    "minimumRequiredAppVersion"                       = var.minimumRequiredAppVersion
    "minimumRequiredOsVersion"                        = var.minimumRequiredOsVersion
    "minimumRequiredPatchVersion"                     = var.minimumRequiredPatchVersion
    "minimumRequiredSdkVersion"                       = var.minimumRequiredSdkVersion
    "minimumWarningAppVersion"                        = var.minimumWarningAppVersion
    "minimumWarningOsVersion"                         = var.minimumWarningOsVersion
    "minimumWarningPatchVersion"                      = var.minimumWarningPatchVersion
    "@odata.type"                                     = var.odata_type
    "organizationalCredentialsRequired"               = var.organizationalCredentialsRequired
    "periodBeforePinReset"                            = var.periodBeforePinReset
    "periodOfflineBeforeAccessCheck"                  = var.periodOfflineBeforeAccessCheck
    "periodOfflineBeforeWipeIsEnforced"               = var.periodOfflineBeforeWipeIsEnforced
    "periodOnlineBeforeAccessCheck"                   = var.periodOnlineBeforeAccessCheck
    "pinCharacterSet"                                 = var.pinCharacterSet
    "pinRequired"                                     = var.pinRequired
    "printBlocked"                                    = var.printBlocked
    "saveAsBlocked"                                   = var.saveAsBlocked
    "screenCaptureBlocked"                            = var.screenCaptureBlocked
    "simplePinBlocked"                                = var.simplePinBlocked
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/defaultManagedAppProtections"
  api_version             = "v1.0"
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
