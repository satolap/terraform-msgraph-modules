# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appleIdentifier"                     = var.apple_identifier
    "dataSharingConsentGranted"           = var.data_sharing_consent_granted
    "defaultIosEnrollmentProfile"         = var.default_ios_enrollment_profile
    "defaultMacOsEnrollmentProfile"       = var.default_mac_os_enrollment_profile
    "defaultTvOSEnrollmentProfile"        = var.default_tv_os_enrollment_profile
    "defaultVisionOSEnrollmentProfile"    = var.default_vision_os_enrollment_profile
    "enrollmentProfiles"                  = (var.enrollment_profiles == null ? null : [for item0 in var.enrollment_profiles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "configurationEndpointUrl" = item0["configurationEndpointUrl"], "description" = item0["description"], "displayName" = item0["displayName"], "enableAuthenticationViaCompanyPortal" = item0["enableAuthenticationViaCompanyPortal"], "requireCompanyPortalOnSetupAssistantEnrolledDevices" = item0["requireCompanyPortalOnSetupAssistantEnrolledDevices"], "requiresUserAuthentication" = item0["requiresUserAuthentication"] } : key1 => value1 if value1 != null }) if item0 != null])
    "importedAppleDeviceIdentities"       = (var.imported_apple_device_identities == null ? null : [for item0 in var.imported_apple_device_identities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "discoverySource" = item0["discoverySource"], "enrollmentState" = item0["enrollmentState"], "isDeleted" = item0["isDeleted"], "isSupervised" = item0["isSupervised"], "lastContactedDateTime" = item0["lastContactedDateTime"], "platform" = item0["platform"], "requestedEnrollmentProfileAssignmentDateTime" = item0["requestedEnrollmentProfileAssignmentDateTime"], "requestedEnrollmentProfileId" = item0["requestedEnrollmentProfileId"], "serialNumber" = item0["serialNumber"] } : key1 => value1 if value1 != null }) if item0 != null])
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

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/depOnboardingSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
