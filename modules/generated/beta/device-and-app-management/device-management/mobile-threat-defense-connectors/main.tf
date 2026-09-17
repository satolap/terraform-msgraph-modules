# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowPartnerToCollectIOSApplicationMetadata"         = var.allow_partner_to_collect_ios_application_metadata
    "allowPartnerToCollectIosCertificateMetadata"         = var.allow_partner_to_collect_ios_certificate_metadata
    "allowPartnerToCollectIOSPersonalApplicationMetadata" = var.allow_partner_to_collect_ios_personal_application_metadata
    "allowPartnerToCollectIosPersonalCertificateMetadata" = var.allow_partner_to_collect_ios_personal_certificate_metadata
    "androidDeviceBlockedOnMissingPartnerData"            = var.android_device_blocked_on_missing_partner_data
    "androidEnabled"                                      = var.android_enabled
    "androidMobileApplicationManagementEnabled"           = var.android_mobile_application_management_enabled
    "grantMobileThreatDefensePartnerRole"                 = var.grant_mobile_threat_defense_partner_role
    "iosDeviceBlockedOnMissingPartnerData"                = var.ios_device_blocked_on_missing_partner_data
    "iosEnabled"                                          = var.ios_enabled
    "iosMobileApplicationManagementEnabled"               = var.ios_mobile_application_management_enabled
    "lastHeartbeatDateTime"                               = var.last_heartbeat_date_time
    "launchMobileThreatDefensePartnerOnSetupEnabled"      = var.launch_mobile_threat_defense_partner_on_setup_enabled
    "macDeviceBlockedOnMissingPartnerData"                = var.mac_device_blocked_on_missing_partner_data
    "macEnabled"                                          = var.mac_enabled
    "microsoftDefenderForEndpointAttachEnabled"           = var.microsoft_defender_for_endpoint_attach_enabled
    "@odata.type"                                         = var.odata_type
    "partnerMinimumSupportedAndroidVersion"               = var.partner_minimum_supported_android_version
    "partnerMinimumSupportedIosVersion"                   = var.partner_minimum_supported_ios_version
    "partnerMinimumSupportedMacVersion"                   = var.partner_minimum_supported_mac_version
    "partnerMinimumSupportedWindowsVersion"               = var.partner_minimum_supported_windows_version
    "partnerState"                                        = var.partner_state
    "partnerSupportsAndroidMam"                           = var.partner_supports_android_mam
    "partnerSupportsIosCertificateSync"                   = var.partner_supports_ios_certificate_sync
    "partnerSupportsIosMam"                               = var.partner_supports_ios_mam
    "partnerSupportsWindowsMam"                           = var.partner_supports_windows_mam
    "partnerUnresponsivenessThresholdInDays"              = var.partner_unresponsiveness_threshold_in_days
    "partnerUnsupportedOsVersionBlocked"                  = var.partner_unsupported_os_version_blocked
    "windowsDeviceBlockedOnMissingPartnerData"            = var.windows_device_blocked_on_missing_partner_data
    "windowsEnabled"                                      = var.windows_enabled
    "windowsMobileApplicationManagementEnabled"           = var.windows_mobile_application_management_enabled
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/mobileThreatDefenseConnectors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
