# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                                 = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "intent" = item0["intent"], "source" = item0["source"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                             = var.created_date_time
    "description"                                 = var.description
    "deviceManagementApplicabilityRuleDeviceMode" = var.device_management_applicability_rule_device_mode
    "deviceManagementApplicabilityRuleOsEdition"  = var.device_management_applicability_rule_os_edition
    "deviceManagementApplicabilityRuleOsVersion"  = var.device_management_applicability_rule_os_version
    "deviceSettingStateSummaries"                 = (var.device_setting_state_summaries == null ? null : [for item0 in var.device_setting_state_summaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "compliantDeviceCount" = item0["compliantDeviceCount"], "conflictDeviceCount" = item0["conflictDeviceCount"], "errorDeviceCount" = item0["errorDeviceCount"], "instancePath" = item0["instancePath"], "nonCompliantDeviceCount" = item0["nonCompliantDeviceCount"], "notApplicableDeviceCount" = item0["notApplicableDeviceCount"], "remediatedDeviceCount" = item0["remediatedDeviceCount"], "settingName" = item0["settingName"], "unknownDeviceCount" = item0["unknownDeviceCount"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceStatusOverview"                        = var.device_status_overview
    "deviceStatuses"                              = (var.device_statuses == null ? null : [for item0 in var.device_statuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "complianceGracePeriodExpirationDateTime" = item0["complianceGracePeriodExpirationDateTime"], "deviceDisplayName" = item0["deviceDisplayName"], "deviceModel" = item0["deviceModel"], "lastReportedDateTime" = item0["lastReportedDateTime"], "platform" = item0["platform"], "status" = item0["status"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                                 = var.display_name
    "version"                                     = var.graph_version
    "groupAssignments"                            = (var.group_assignments == null ? null : [for item0 in var.group_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceConfiguration" = item0["deviceConfiguration"], "excludeGroup" = item0["excludeGroup"], "targetGroupId" = item0["targetGroupId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime"                        = var.last_modified_date_time
    "@odata.type"                                 = var.odata_type
    "roleScopeTagIds"                             = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "userStatusOverview"                          = var.user_status_overview
    "userStatuses"                                = (var.user_statuses == null ? null : [for item0 in var.user_statuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "devicesCount" = item0["devicesCount"], "lastReportedDateTime" = item0["lastReportedDateTime"], "status" = item0["status"], "userDisplayName" = item0["userDisplayName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
