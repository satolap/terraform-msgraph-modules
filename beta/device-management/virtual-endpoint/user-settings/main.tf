# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                        = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                    = var.created_date_time
    "crossRegionDisasterRecoverySetting" = (var.cross_region_disaster_recovery_setting == null ? null : { for key0, value0 in { "@odata.type" = var.cross_region_disaster_recovery_setting["odata_type"], "crossRegionDisasterRecoveryEnabled" = var.cross_region_disaster_recovery_setting["crossRegionDisasterRecoveryEnabled"], "disasterRecoveryNetworkSetting" = var.cross_region_disaster_recovery_setting["disasterRecoveryNetworkSetting"], "disasterRecoveryType" = var.cross_region_disaster_recovery_setting["disasterRecoveryType"], "maintainCrossRegionRestorePointEnabled" = var.cross_region_disaster_recovery_setting["maintainCrossRegionRestorePointEnabled"], "userInitiatedDisasterRecoveryAllowed" = var.cross_region_disaster_recovery_setting["userInitiatedDisasterRecoveryAllowed"] } : key0 => value0 if value0 != null })
    "displayName"                        = var.display_name
    "lastModifiedDateTime"               = var.last_modified_date_time
    "localAdminEnabled"                  = var.local_admin_enabled
    "notificationSetting"                = (var.notification_setting == null ? null : { for key0, value0 in { "@odata.type" = var.notification_setting["odata_type"], "restartPromptsDisabled" = var.notification_setting["restartPromptsDisabled"] } : key0 => value0 if value0 != null })
    "@odata.type"                        = var.odata_type
    "provisioningSourceType"             = var.provisioning_source_type
    "resetEnabled"                       = var.reset_enabled
    "restorePointSetting"                = (var.restore_point_setting == null ? null : { for key0, value0 in { "@odata.type" = var.restore_point_setting["odata_type"], "frequencyInHours" = var.restore_point_setting["frequencyInHours"], "frequencyType" = var.restore_point_setting["frequencyType"], "userRestoreEnabled" = var.restore_point_setting["userRestoreEnabled"] } : key0 => value0 if value0 != null })
    "selfServiceEnabled"                 = var.self_service_enabled
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/userSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
