# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                        = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                    = var.createdDateTime
    "crossRegionDisasterRecoverySetting" = (var.crossRegionDisasterRecoverySetting == null ? null : { for key0, value0 in { "@odata.type" = var.crossRegionDisasterRecoverySetting["odata_type"], "crossRegionDisasterRecoveryEnabled" = var.crossRegionDisasterRecoverySetting["crossRegionDisasterRecoveryEnabled"], "disasterRecoveryNetworkSetting" = var.crossRegionDisasterRecoverySetting["disasterRecoveryNetworkSetting"], "disasterRecoveryType" = var.crossRegionDisasterRecoverySetting["disasterRecoveryType"], "maintainCrossRegionRestorePointEnabled" = var.crossRegionDisasterRecoverySetting["maintainCrossRegionRestorePointEnabled"], "userInitiatedDisasterRecoveryAllowed" = var.crossRegionDisasterRecoverySetting["userInitiatedDisasterRecoveryAllowed"] } : key0 => value0 if value0 != null })
    "displayName"                        = var.displayName
    "lastModifiedDateTime"               = var.lastModifiedDateTime
    "localAdminEnabled"                  = var.localAdminEnabled
    "notificationSetting"                = (var.notificationSetting == null ? null : { for key0, value0 in { "@odata.type" = var.notificationSetting["odata_type"], "restartPromptsDisabled" = var.notificationSetting["restartPromptsDisabled"] } : key0 => value0 if value0 != null })
    "@odata.type"                        = var.odata_type
    "provisioningSourceType"             = var.provisioningSourceType
    "resetEnabled"                       = var.resetEnabled
    "restorePointSetting"                = (var.restorePointSetting == null ? null : { for key0, value0 in { "@odata.type" = var.restorePointSetting["odata_type"], "frequencyInHours" = var.restorePointSetting["frequencyInHours"], "frequencyType" = var.restorePointSetting["frequencyType"], "userRestoreEnabled" = var.restorePointSetting["userRestoreEnabled"] } : key0 => value0 if value0 != null })
    "selfServiceEnabled"                 = var.selfServiceEnabled
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/userSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments"], name)])]))))] } : null

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
