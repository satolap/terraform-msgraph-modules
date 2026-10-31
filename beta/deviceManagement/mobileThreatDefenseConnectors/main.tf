# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowPartnerToCollectIOSApplicationMetadata"         = var.allowPartnerToCollectIOSApplicationMetadata
    "allowPartnerToCollectIOSPersonalApplicationMetadata" = var.allowPartnerToCollectIOSPersonalApplicationMetadata
    "allowPartnerToCollectIosCertificateMetadata"         = var.allowPartnerToCollectIosCertificateMetadata
    "allowPartnerToCollectIosPersonalCertificateMetadata" = var.allowPartnerToCollectIosPersonalCertificateMetadata
    "androidDeviceBlockedOnMissingPartnerData"            = var.androidDeviceBlockedOnMissingPartnerData
    "androidEnabled"                                      = var.androidEnabled
    "androidMobileApplicationManagementEnabled"           = var.androidMobileApplicationManagementEnabled
    "grantMobileThreatDefensePartnerRole"                 = var.grantMobileThreatDefensePartnerRole
    "iosDeviceBlockedOnMissingPartnerData"                = var.iosDeviceBlockedOnMissingPartnerData
    "iosEnabled"                                          = var.iosEnabled
    "iosMobileApplicationManagementEnabled"               = var.iosMobileApplicationManagementEnabled
    "lastHeartbeatDateTime"                               = var.lastHeartbeatDateTime
    "launchMobileThreatDefensePartnerOnSetupEnabled"      = var.launchMobileThreatDefensePartnerOnSetupEnabled
    "macDeviceBlockedOnMissingPartnerData"                = var.macDeviceBlockedOnMissingPartnerData
    "macEnabled"                                          = var.macEnabled
    "microsoftDefenderForEndpointAttachEnabled"           = var.microsoftDefenderForEndpointAttachEnabled
    "@odata.type"                                         = var.odata_type
    "partnerMinimumSupportedAndroidVersion"               = var.partnerMinimumSupportedAndroidVersion
    "partnerMinimumSupportedIosVersion"                   = var.partnerMinimumSupportedIosVersion
    "partnerMinimumSupportedMacVersion"                   = var.partnerMinimumSupportedMacVersion
    "partnerMinimumSupportedWindowsVersion"               = var.partnerMinimumSupportedWindowsVersion
    "partnerState"                                        = var.partnerState
    "partnerSupportsAndroidMam"                           = var.partnerSupportsAndroidMam
    "partnerSupportsIosCertificateSync"                   = var.partnerSupportsIosCertificateSync
    "partnerSupportsIosMam"                               = var.partnerSupportsIosMam
    "partnerSupportsWindowsMam"                           = var.partnerSupportsWindowsMam
    "partnerUnresponsivenessThresholdInDays"              = var.partnerUnresponsivenessThresholdInDays
    "partnerUnsupportedOsVersionBlocked"                  = var.partnerUnsupportedOsVersionBlocked
    "windowsDeviceBlockedOnMissingPartnerData"            = var.windowsDeviceBlockedOnMissingPartnerData
    "windowsEnabled"                                      = var.windowsEnabled
    "windowsMobileApplicationManagementEnabled"           = var.windowsMobileApplicationManagementEnabled
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/mobileThreatDefenseConnectors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
