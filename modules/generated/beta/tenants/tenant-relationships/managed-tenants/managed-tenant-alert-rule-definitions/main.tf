# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertRules"         = (var.alert_rules == null ? null : [for item0 in var.alert_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "alertDisplayName" = item0["alertDisplayName"], "alertTTL" = item0["alertTTL"], "alerts" = (item0["alerts"] == null ? null : [for item2 in item0["alerts"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "alertData" = item2["alertData"], "alertDataReferenceStrings" = (item2["alertDataReferenceStrings"] == null ? null : [for item4 in item2["alertDataReferenceStrings"] : item4 if item4 != null]), "alertLogs" = (item2["alertLogs"] == null ? null : [for item4 in item2["alertLogs"] : item4 if item4 != null]), "alertRule" = item2["alertRule"], "alertRuleDisplayName" = item2["alertRuleDisplayName"], "apiNotifications" = (item2["apiNotifications"] == null ? null : [for item4 in item2["apiNotifications"] : item4 if item4 != null]), "assignedToUserId" = item2["assignedToUserId"], "correlationCount" = item2["correlationCount"], "correlationId" = item2["correlationId"], "createdByUserId" = item2["createdByUserId"], "createdDateTime" = item2["createdDateTime"], "emailNotifications" = (item2["emailNotifications"] == null ? null : [for item4 in item2["emailNotifications"] : item4 if item4 != null]), "lastActionByUserId" = item2["lastActionByUserId"], "lastActionDateTime" = item2["lastActionDateTime"], "message" = item2["message"], "severity" = item2["severity"], "status" = item2["status"], "tenantId" = item2["tenantId"], "title" = item2["title"] } : key3 => value3 if value3 != null }) if item2 != null]), "createdByUserId" = item0["createdByUserId"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastActionByUserId" = item0["lastActionByUserId"], "lastActionDateTime" = item0["lastActionDateTime"], "lastRunDateTime" = item0["lastRunDateTime"], "notificationFinalDestinations" = item0["notificationFinalDestinations"], "ruleDefinition" = item0["ruleDefinition"], "severity" = item0["severity"], "targets" = (item0["targets"] == null ? null : [for item2 in item0["targets"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"] } : key3 => value3 if value3 != null }) if item2 != null]), "tenantIds" = (item0["tenantIds"] == null ? null : [for item2 in item0["tenantIds"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "tenantId" = item2["tenantId"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "createdByUserId"    = var.created_by_user_id
    "createdDateTime"    = var.created_date_time
    "definitionTemplate" = var.definition_template
    "displayName"        = var.display_name
    "lastActionByUserId" = var.last_action_by_user_id
    "lastActionDateTime" = var.last_action_date_time
    "@odata.type"        = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/managedTenantAlertRuleDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
