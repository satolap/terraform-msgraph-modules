# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertData"                 = var.alert_data
    "alertDataReferenceStrings" = (var.alert_data_reference_strings == null ? null : [for item0 in var.alert_data_reference_strings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "alertLogs"                 = (var.alert_logs == null ? null : [for item0 in var.alert_logs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "alert" = item0["alert"], "content" = item0["content"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "alertRule"                 = var.alert_rule
    "alertRuleDisplayName"      = var.alert_rule_display_name
    "apiNotifications"          = (var.api_notifications == null ? null : [for item0 in var.api_notifications : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "alert" = item0["alert"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "isAcknowledged" = item0["isAcknowledged"], "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "message" = item0["message"], "title" = item0["title"], "userId" = item0["userId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignedToUserId"          = var.assigned_to_user_id
    "correlationCount"          = var.correlation_count
    "correlationId"             = var.correlation_id
    "createdByUserId"           = var.created_by_user_id
    "createdDateTime"           = var.created_date_time
    "emailNotifications"        = (var.email_notifications == null ? null : [for item0 in var.email_notifications : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "alert" = item0["alert"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "emailAddresses" = (item0["emailAddresses"] == null ? null : [for item2 in item0["emailAddresses"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "emailAddress" = item2["emailAddress"] } : key3 => value3 if value3 != null }) if item2 != null]), "emailBody" = item0["emailBody"], "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "subject" = item0["subject"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastActionByUserId"        = var.last_action_by_user_id
    "lastActionDateTime"        = var.last_action_date_time
    "message"                   = var.message
    "@odata.type"               = var.odata_type
    "severity"                  = var.severity
    "status"                    = var.status
    "tenantId"                  = var.tenant_id
    "title"                     = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managedTenantAlerts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
