# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertDisplayName"              = var.alert_display_name
    "alertTTL"                      = var.alert_ttl
    "alerts"                        = (var.alerts == null ? null : [for item0 in var.alerts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "alertData" = item0["alertData"], "alertDataReferenceStrings" = (item0["alertDataReferenceStrings"] == null ? null : [for item2 in item0["alertDataReferenceStrings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"] } : key3 => value3 if value3 != null }) if item2 != null]), "alertLogs" = (item0["alertLogs"] == null ? null : [for item2 in item0["alertLogs"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "alert" = item2["alert"], "content" = item2["content"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "alertRule" = item0["alertRule"], "alertRuleDisplayName" = item0["alertRuleDisplayName"], "apiNotifications" = (item0["apiNotifications"] == null ? null : [for item2 in item0["apiNotifications"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "alert" = item2["alert"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "isAcknowledged" = item2["isAcknowledged"], "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "message" = item2["message"], "title" = item2["title"], "userId" = item2["userId"] } : key3 => value3 if value3 != null }) if item2 != null]), "assignedToUserId" = item0["assignedToUserId"], "correlationCount" = item0["correlationCount"], "correlationId" = item0["correlationId"], "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "emailNotifications" = (item0["emailNotifications"] == null ? null : [for item2 in item0["emailNotifications"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "alert" = item2["alert"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "emailAddresses" = (item2["emailAddresses"] == null ? null : [for item4 in item2["emailAddresses"] : item4 if item4 != null]), "emailBody" = item2["emailBody"], "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "subject" = item2["subject"] } : key3 => value3 if value3 != null }) if item2 != null]), "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "message" = item0["message"], "severity" = item0["severity"], "status" = item0["status"], "tenantId" = item0["tenantId"], "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdByUserId"               = var.created_by_user_id
    "createdDateTime"               = var.created_date_time
    "description"                   = var.description
    "displayName"                   = var.display_name
    "lastActionByUserId"            = var.last_action_by_user_id
    "lastActionDateTime"            = var.last_action_date_time
    "lastRunDateTime"               = var.last_run_date_time
    "notificationFinalDestinations" = var.notification_final_destinations
    "@odata.type"                   = var.odata_type
    "ruleDefinition"                = var.rule_definition
    "severity"                      = var.severity
    "targets"                       = (var.targets == null ? null : [for item0 in var.targets : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tenantIds"                     = (var.tenant_ids == null ? null : [for item0 in var.tenant_ids : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "tenantId" = item0["tenantId"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managedTenantAlertRules"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
