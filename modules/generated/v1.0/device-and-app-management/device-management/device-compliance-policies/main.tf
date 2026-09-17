# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                 = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"             = var.created_date_time
    "description"                 = var.description
    "deviceSettingStateSummaries" = (var.device_setting_state_summaries == null ? null : [for item0 in var.device_setting_state_summaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "compliantDeviceCount" = item0["compliantDeviceCount"], "conflictDeviceCount" = item0["conflictDeviceCount"], "errorDeviceCount" = item0["errorDeviceCount"], "instancePath" = item0["instancePath"], "nonCompliantDeviceCount" = item0["nonCompliantDeviceCount"], "notApplicableDeviceCount" = item0["notApplicableDeviceCount"], "remediatedDeviceCount" = item0["remediatedDeviceCount"], "settingName" = item0["settingName"], "unknownDeviceCount" = item0["unknownDeviceCount"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceStatusOverview"        = var.device_status_overview
    "deviceStatuses"              = (var.device_statuses == null ? null : [for item0 in var.device_statuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "complianceGracePeriodExpirationDateTime" = item0["complianceGracePeriodExpirationDateTime"], "deviceDisplayName" = item0["deviceDisplayName"], "deviceModel" = item0["deviceModel"], "lastReportedDateTime" = item0["lastReportedDateTime"], "status" = item0["status"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                 = var.display_name
    "version"                     = var.graph_version
    "lastModifiedDateTime"        = var.last_modified_date_time
    "@odata.type"                 = var.odata_type
    "scheduledActionsForRule"     = (var.scheduled_actions_for_rule == null ? null : [for item0 in var.scheduled_actions_for_rule : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ruleName" = item0["ruleName"], "scheduledActionConfigurations" = (item0["scheduledActionConfigurations"] == null ? null : [for item2 in item0["scheduledActionConfigurations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "actionType" = item2["actionType"], "gracePeriodHours" = item2["gracePeriodHours"], "notificationMessageCCList" = (item2["notificationMessageCCList"] == null ? null : [for item4 in item2["notificationMessageCCList"] : item4 if item4 != null]), "notificationTemplateId" = item2["notificationTemplateId"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "userStatusOverview"          = var.user_status_overview
    "userStatuses"                = (var.user_statuses == null ? null : [for item0 in var.user_statuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "devicesCount" = item0["devicesCount"], "lastReportedDateTime" = item0["lastReportedDateTime"], "status" = item0["status"], "userDisplayName" = item0["userDisplayName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceCompliancePolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
