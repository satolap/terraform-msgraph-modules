# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowPartnerToCollectIOSApplicationMetadata"         = var.allow_partner_to_collect_ios_application_metadata
    "allowPartnerToCollectIOSPersonalApplicationMetadata" = var.allow_partner_to_collect_ios_personal_application_metadata
    "androidDeviceBlockedOnMissingPartnerData"            = var.android_device_blocked_on_missing_partner_data
    "androidEnabled"                                      = var.android_enabled
    "androidMobileApplicationManagementEnabled"           = var.android_mobile_application_management_enabled
    "iosDeviceBlockedOnMissingPartnerData"                = var.ios_device_blocked_on_missing_partner_data
    "iosEnabled"                                          = var.ios_enabled
    "iosMobileApplicationManagementEnabled"               = var.ios_mobile_application_management_enabled
    "lastHeartbeatDateTime"                               = var.last_heartbeat_date_time
    "microsoftDefenderForEndpointAttachEnabled"           = var.microsoft_defender_for_endpoint_attach_enabled
    "@odata.type"                                         = var.odata_type
    "partnerState"                                        = var.partner_state
    "partnerUnresponsivenessThresholdInDays"              = var.partner_unresponsiveness_threshold_in_days
    "partnerUnsupportedOsVersionBlocked"                  = var.partner_unsupported_os_version_blocked
    "windowsDeviceBlockedOnMissingPartnerData"            = var.windows_device_blocked_on_missing_partner_data
    "windowsEnabled"                                      = var.windows_enabled
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/mobileThreatDefenseConnectors"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
