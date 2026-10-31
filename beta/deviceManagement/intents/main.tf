# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                      = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "categories"                       = (var.categories == null ? null : [for item0 in var.categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "hasRequiredSetting" = item0["hasRequiredSetting"], "settingDefinitions" = (item0["settingDefinitions"] == null ? null : [for item2 in item0["settingDefinitions"] : item2 if item2 != null]), "settings" = (item0["settings"] == null ? null : [for item2 in item0["settings"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                      = var.description
    "deviceSettingStateSummaries"      = (var.deviceSettingStateSummaries == null ? null : [for item0 in var.deviceSettingStateSummaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "compliantCount" = item0["compliantCount"], "conflictCount" = item0["conflictCount"], "errorCount" = item0["errorCount"], "nonCompliantCount" = item0["nonCompliantCount"], "notApplicableCount" = item0["notApplicableCount"], "remediatedCount" = item0["remediatedCount"], "settingName" = item0["settingName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceStateSummary"               = var.deviceStateSummary
    "deviceStates"                     = (var.deviceStates == null ? null : [for item0 in var.deviceStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceDisplayName" = item0["deviceDisplayName"], "deviceId" = item0["deviceId"], "lastReportedDateTime" = item0["lastReportedDateTime"], "state" = item0["state"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                      = var.displayName
    "isAssigned"                       = var.isAssigned
    "isMigratingToConfigurationPolicy" = var.isMigratingToConfigurationPolicy
    "lastModifiedDateTime"             = var.lastModifiedDateTime
    "@odata.type"                      = var.odata_type
    "roleScopeTagIds"                  = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "settings"                         = (var.settings == null ? null : [for item0 in var.settings : item0 if item0 != null])
    "templateId"                       = var.templateId
    "userStateSummary"                 = var.userStateSummary
    "userStates"                       = (var.userStates == null ? null : [for item0 in var.userStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceCount" = item0["deviceCount"], "lastReportedDateTime" = item0["lastReportedDateTime"], "state" = item0["state"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/intents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "categories", "deviceSettingStateSummaries", "deviceStateSummary", "deviceStates", "settings", "userStateSummary", "userStates"], name)])]))))] } : null

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
