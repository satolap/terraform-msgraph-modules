# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowWidgetContentSync"                         = var.allow_widget_content_sync
    "allowedDataIngestionLocations"                  = (var.allowed_data_ingestion_locations == null ? null : [for item0 in var.allowed_data_ingestion_locations : item0 if item0 != null])
    "allowedDataStorageLocations"                    = (var.allowed_data_storage_locations == null ? null : [for item0 in var.allowed_data_storage_locations : item0 if item0 != null])
    "allowedInboundDataTransferSources"              = var.allowed_inbound_data_transfer_sources
    "allowedIosDeviceModels"                         = var.allowed_ios_device_models
    "allowedOutboundClipboardSharingExceptionLength" = var.allowed_outbound_clipboard_sharing_exception_length
    "allowedOutboundClipboardSharingLevel"           = var.allowed_outbound_clipboard_sharing_level
    "allowedOutboundDataTransferDestinations"        = var.allowed_outbound_data_transfer_destinations
    "appActionIfAccountIsClockedOut"                 = var.app_action_if_account_is_clocked_out
    "appActionIfDeviceComplianceRequired"            = var.app_action_if_device_compliance_required
    "appActionIfIosDeviceModelNotAllowed"            = var.app_action_if_ios_device_model_not_allowed
    "appActionIfMaximumPinRetriesExceeded"           = var.app_action_if_maximum_pin_retries_exceeded
    "appActionIfUnableToAuthenticateUser"            = var.app_action_if_unable_to_authenticate_user
    "appDataEncryptionType"                          = var.app_data_encryption_type
    "appGroupType"                                   = var.app_group_type
    "apps"                                           = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                                    = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "blockDataIngestionIntoOrganizationDocuments"    = var.block_data_ingestion_into_organization_documents
    "contactSyncBlocked"                             = var.contact_sync_blocked
    "createdDateTime"                                = var.created_date_time
    "customBrowserProtocol"                          = var.custom_browser_protocol
    "customDialerAppProtocol"                        = var.custom_dialer_app_protocol
    "dataBackupBlocked"                              = var.data_backup_blocked
    "deployedAppCount"                               = var.deployed_app_count
    "deploymentSummary"                              = var.deployment_summary
    "description"                                    = var.description
    "deviceComplianceRequired"                       = var.device_compliance_required
    "dialerRestrictionLevel"                         = var.dialer_restriction_level
    "disableAppPinIfDevicePinIsSet"                  = var.disable_app_pin_if_device_pin_is_set
    "disableProtectionOfManagedOutboundOpenInData"   = var.disable_protection_of_managed_outbound_open_in_data
    "displayName"                                    = var.display_name
    "exemptedAppProtocols"                           = (var.exempted_app_protocols == null ? null : [for item0 in var.exempted_app_protocols : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "exemptedUniversalLinks"                         = (var.exempted_universal_links == null ? null : [for item0 in var.exempted_universal_links : item0 if item0 != null])
    "faceIdBlocked"                                  = var.face_id_blocked
    "filterOpenInToOnlyManagedApps"                  = var.filter_open_in_to_only_managed_apps
    "fingerprintBlocked"                             = var.fingerprint_blocked
    "genmojiConfigurationState"                      = var.genmoji_configuration_state
    "gracePeriodToBlockAppsDuringOffClockHours"      = var.grace_period_to_block_apps_during_off_clock_hours
    "version"                                        = var.graph_version
    "isAssigned"                                     = var.is_assigned
    "lastModifiedDateTime"                           = var.last_modified_date_time
    "managedBrowser"                                 = var.managed_browser
    "managedBrowserToOpenLinksRequired"              = var.managed_browser_to_open_links_required
    "managedUniversalLinks"                          = (var.managed_universal_links == null ? null : [for item0 in var.managed_universal_links : item0 if item0 != null])
    "maximumAllowedDeviceThreatLevel"                = var.maximum_allowed_device_threat_level
    "maximumPinRetries"                              = var.maximum_pin_retries
    "maximumRequiredOsVersion"                       = var.maximum_required_os_version
    "maximumWarningOsVersion"                        = var.maximum_warning_os_version
    "maximumWipeOsVersion"                           = var.maximum_wipe_os_version
    "messagingRedirectAppUrlScheme"                  = var.messaging_redirect_app_url_scheme
    "minimumPinLength"                               = var.minimum_pin_length
    "minimumRequiredAppVersion"                      = var.minimum_required_app_version
    "minimumRequiredOsVersion"                       = var.minimum_required_os_version
    "minimumRequiredSdkVersion"                      = var.minimum_required_sdk_version
    "minimumWarningAppVersion"                       = var.minimum_warning_app_version
    "minimumWarningOsVersion"                        = var.minimum_warning_os_version
    "minimumWarningSdkVersion"                       = var.minimum_warning_sdk_version
    "minimumWipeAppVersion"                          = var.minimum_wipe_app_version
    "minimumWipeOsVersion"                           = var.minimum_wipe_os_version
    "minimumWipeSdkVersion"                          = var.minimum_wipe_sdk_version
    "mobileThreatDefensePartnerPriority"             = var.mobile_threat_defense_partner_priority
    "mobileThreatDefenseRemediationAction"           = var.mobile_threat_defense_remediation_action
    "notificationRestriction"                        = var.notification_restriction
    "@odata.type"                                    = var.odata_type
    "organizationalCredentialsRequired"              = var.organizational_credentials_required
    "periodBeforePinReset"                           = var.period_before_pin_reset
    "periodOfflineBeforeAccessCheck"                 = var.period_offline_before_access_check
    "periodOfflineBeforeWipeIsEnforced"              = var.period_offline_before_wipe_is_enforced
    "periodOnlineBeforeAccessCheck"                  = var.period_online_before_access_check
    "pinCharacterSet"                                = var.pin_character_set
    "pinRequired"                                    = var.pin_required
    "pinRequiredInsteadOfBiometricTimeout"           = var.pin_required_instead_of_biometric_timeout
    "previousPinBlockCount"                          = var.previous_pin_block_count
    "printBlocked"                                   = var.print_blocked
    "protectInboundDataFromUnknownSources"           = var.protect_inbound_data_from_unknown_sources
    "protectedMessagingRedirectAppType"              = var.protected_messaging_redirect_app_type
    "purviewContentEvaluationRequired"               = var.purview_content_evaluation_required
    "roleScopeTagIds"                                = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "saveAsBlocked"                                  = var.save_as_blocked
    "screenCaptureConfigurationState"                = var.screen_capture_configuration_state
    "simplePinBlocked"                               = var.simple_pin_blocked
    "targetedAppManagementLevels"                    = var.targeted_app_management_levels
    "thirdPartyKeyboardsBlocked"                     = var.third_party_keyboards_blocked
    "writingToolsConfigurationState"                 = var.writing_tools_configuration_state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/iosManagedAppProtections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
