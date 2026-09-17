# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                      = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "categories"                       = (var.categories == null ? null : [for item0 in var.categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "hasRequiredSetting" = item0["hasRequiredSetting"], "settingDefinitions" = (item0["settingDefinitions"] == null ? null : [for item2 in item0["settingDefinitions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "constraints" = (item2["constraints"] == null ? null : [for item4 in item2["constraints"] : item4 if item4 != null]), "dependencies" = (item2["dependencies"] == null ? null : [for item4 in item2["dependencies"] : item4 if item4 != null]), "description" = item2["description"], "displayName" = item2["displayName"], "documentationUrl" = item2["documentationUrl"], "headerSubtitle" = item2["headerSubtitle"], "headerTitle" = item2["headerTitle"], "isTopLevel" = item2["isTopLevel"], "keywords" = (item2["keywords"] == null ? null : [for item4 in item2["keywords"] : item4 if item4 != null]), "placeholderText" = item2["placeholderText"], "valueType" = item2["valueType"] } : key3 => value3 if value3 != null }) if item2 != null]), "settings" = (item0["settings"] == null ? null : [for item2 in item0["settings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "definitionId" = item2["definitionId"], "valueJson" = item2["valueJson"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                      = var.description
    "deviceSettingStateSummaries"      = (var.device_setting_state_summaries == null ? null : [for item0 in var.device_setting_state_summaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "compliantCount" = item0["compliantCount"], "conflictCount" = item0["conflictCount"], "errorCount" = item0["errorCount"], "nonCompliantCount" = item0["nonCompliantCount"], "notApplicableCount" = item0["notApplicableCount"], "remediatedCount" = item0["remediatedCount"], "settingName" = item0["settingName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceStateSummary"               = var.device_state_summary
    "deviceStates"                     = (var.device_states == null ? null : [for item0 in var.device_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceDisplayName" = item0["deviceDisplayName"], "deviceId" = item0["deviceId"], "lastReportedDateTime" = item0["lastReportedDateTime"], "state" = item0["state"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                      = var.display_name
    "isAssigned"                       = var.is_assigned
    "isMigratingToConfigurationPolicy" = var.is_migrating_to_configuration_policy
    "lastModifiedDateTime"             = var.last_modified_date_time
    "@odata.type"                      = var.odata_type
    "roleScopeTagIds"                  = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "settings"                         = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "definitionId" = item0["definitionId"], "valueJson" = item0["valueJson"] } : key1 => value1 if value1 != null }) if item0 != null])
    "templateId"                       = var.template_id
    "userStateSummary"                 = var.user_state_summary
    "userStates"                       = (var.user_states == null ? null : [for item0 in var.user_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceCount" = item0["deviceCount"], "lastReportedDateTime" = item0["lastReportedDateTime"], "state" = item0["state"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/intents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
