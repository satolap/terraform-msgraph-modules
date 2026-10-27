# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appleIdentifier"                     = var.apple_identifier
    "dataSharingConsentGranted"           = var.data_sharing_consent_granted
    "defaultIosEnrollmentProfile"         = var.default_ios_enrollment_profile
    "defaultMacOsEnrollmentProfile"       = var.default_mac_os_enrollment_profile
    "defaultTvOSEnrollmentProfile"        = var.default_tv_os_enrollment_profile
    "defaultVisionOSEnrollmentProfile"    = var.default_vision_os_enrollment_profile
    "enrollmentProfiles"                  = (var.enrollment_profiles == null ? null : [for item0 in var.enrollment_profiles : item0 if item0 != null])
    "importedAppleDeviceIdentities"       = (var.imported_apple_device_identities == null ? null : [for item0 in var.imported_apple_device_identities : item0 if item0 != null])
    "lastModifiedDateTime"                = var.last_modified_date_time
    "lastSuccessfulSyncDateTime"          = var.last_successful_sync_date_time
    "lastSyncErrorCode"                   = var.last_sync_error_code
    "lastSyncTriggeredDateTime"           = var.last_sync_triggered_date_time
    "@odata.type"                         = var.odata_type
    "roleScopeTagIds"                     = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "shareTokenWithSchoolDataSyncService" = var.share_token_with_school_data_sync_service
    "syncedDeviceCount"                   = var.synced_device_count
    "tokenExpirationDateTime"             = var.token_expiration_date_time
    "tokenName"                           = var.token_name
    "tokenType"                           = var.token_type
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
