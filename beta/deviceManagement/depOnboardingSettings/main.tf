# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appleIdentifier"                     = var.appleIdentifier
    "dataSharingConsentGranted"           = var.dataSharingConsentGranted
    "defaultIosEnrollmentProfile"         = var.defaultIosEnrollmentProfile
    "defaultMacOsEnrollmentProfile"       = var.defaultMacOsEnrollmentProfile
    "defaultTvOSEnrollmentProfile"        = var.defaultTvOSEnrollmentProfile
    "defaultVisionOSEnrollmentProfile"    = var.defaultVisionOSEnrollmentProfile
    "enrollmentProfiles"                  = (var.enrollmentProfiles == null ? null : [for item0 in var.enrollmentProfiles : item0 if item0 != null])
    "importedAppleDeviceIdentities"       = (var.importedAppleDeviceIdentities == null ? null : [for item0 in var.importedAppleDeviceIdentities : item0 if item0 != null])
    "lastModifiedDateTime"                = var.lastModifiedDateTime
    "lastSuccessfulSyncDateTime"          = var.lastSuccessfulSyncDateTime
    "lastSyncErrorCode"                   = var.lastSyncErrorCode
    "lastSyncTriggeredDateTime"           = var.lastSyncTriggeredDateTime
    "@odata.type"                         = var.odata_type
    "roleScopeTagIds"                     = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "shareTokenWithSchoolDataSyncService" = var.shareTokenWithSchoolDataSyncService
    "syncedDeviceCount"                   = var.syncedDeviceCount
    "tokenExpirationDateTime"             = var.tokenExpirationDateTime
    "tokenName"                           = var.tokenName
    "tokenType"                           = var.tokenType
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/depOnboardingSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["defaultIosEnrollmentProfile", "defaultMacOsEnrollmentProfile", "defaultTvOSEnrollmentProfile", "defaultVisionOSEnrollmentProfile", "enrollmentProfiles", "importedAppleDeviceIdentities"], name)])]))))] } : null

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
