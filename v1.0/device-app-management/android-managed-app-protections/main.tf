# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedDataStorageLocations"                     = (var.allowed_data_storage_locations == null ? null : [for item0 in var.allowed_data_storage_locations : item0 if item0 != null])
    "allowedInboundDataTransferSources"               = var.allowed_inbound_data_transfer_sources
    "allowedOutboundClipboardSharingLevel"            = var.allowed_outbound_clipboard_sharing_level
    "allowedOutboundDataTransferDestinations"         = var.allowed_outbound_data_transfer_destinations
    "apps"                                            = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                                     = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "contactSyncBlocked"                              = var.contact_sync_blocked
    "createdDateTime"                                 = var.created_date_time
    "customBrowserDisplayName"                        = var.custom_browser_display_name
    "customBrowserPackageId"                          = var.custom_browser_package_id
    "dataBackupBlocked"                               = var.data_backup_blocked
    "deployedAppCount"                                = var.deployed_app_count
    "deploymentSummary"                               = var.deployment_summary
    "description"                                     = var.description
    "deviceComplianceRequired"                        = var.device_compliance_required
    "disableAppEncryptionIfDeviceEncryptionIsEnabled" = var.disable_app_encryption_if_device_encryption_is_enabled
    "disableAppPinIfDevicePinIsSet"                   = var.disable_app_pin_if_device_pin_is_set
    "displayName"                                     = var.display_name
    "encryptAppData"                                  = var.encrypt_app_data
    "fingerprintBlocked"                              = var.fingerprint_blocked
    "version"                                         = var.graph_version
    "isAssigned"                                      = var.is_assigned
    "lastModifiedDateTime"                            = var.last_modified_date_time
    "managedBrowser"                                  = var.managed_browser
    "managedBrowserToOpenLinksRequired"               = var.managed_browser_to_open_links_required
    "maximumPinRetries"                               = var.maximum_pin_retries
    "minimumPinLength"                                = var.minimum_pin_length
    "minimumRequiredAppVersion"                       = var.minimum_required_app_version
    "minimumRequiredOsVersion"                        = var.minimum_required_os_version
    "minimumRequiredPatchVersion"                     = var.minimum_required_patch_version
    "minimumWarningAppVersion"                        = var.minimum_warning_app_version
    "minimumWarningOsVersion"                         = var.minimum_warning_os_version
    "minimumWarningPatchVersion"                      = var.minimum_warning_patch_version
    "@odata.type"                                     = var.odata_type
    "organizationalCredentialsRequired"               = var.organizational_credentials_required
    "periodBeforePinReset"                            = var.period_before_pin_reset
    "periodOfflineBeforeAccessCheck"                  = var.period_offline_before_access_check
    "periodOfflineBeforeWipeIsEnforced"               = var.period_offline_before_wipe_is_enforced
    "periodOnlineBeforeAccessCheck"                   = var.period_online_before_access_check
    "pinCharacterSet"                                 = var.pin_character_set
    "pinRequired"                                     = var.pin_required
    "printBlocked"                                    = var.print_blocked
    "saveAsBlocked"                                   = var.save_as_blocked
    "screenCaptureBlocked"                            = var.screen_capture_blocked
    "simplePinBlocked"                                = var.simple_pin_blocked
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/androidManagedAppProtections"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
