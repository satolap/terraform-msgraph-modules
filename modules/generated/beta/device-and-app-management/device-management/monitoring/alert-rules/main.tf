# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertRuleTemplate"    = var.alert_rule_template
    "conditions"           = (var.conditions == null ? null : [for item0 in var.conditions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "aggregation" = item0["aggregation"], "conditionCategory" = item0["conditionCategory"], "operator" = item0["operator"], "relationshipType" = item0["relationshipType"], "thresholdValue" = item0["thresholdValue"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"          = var.description
    "displayName"          = var.display_name
    "enabled"              = var.enabled
    "isSystemRule"         = var.is_system_rule
    "notificationChannels" = (var.notification_channels == null ? null : [for item0 in var.notification_channels : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "notificationChannelType" = item0["notificationChannelType"], "notificationReceivers" = (item0["notificationReceivers"] == null ? null : [for item2 in item0["notificationReceivers"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "contactInformation" = item2["contactInformation"], "locale" = item2["locale"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"          = var.odata_type
    "severity"             = var.severity
    "threshold"            = var.threshold
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/monitoring/alertRules"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
