# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertImpact"         = (var.alert_impact == null ? null : { for key0, value0 in { "@odata.type" = var.alert_impact["odata_type"], "aggregationType" = var.alert_impact["aggregationType"], "alertImpactDetails" = (var.alert_impact["alertImpactDetails"] == null ? null : [for item1 in var.alert_impact["alertImpactDetails"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "name" = item1["name"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "value" = var.alert_impact["value"] } : key0 => value0 if value0 != null })
    "alertRuleId"         = var.alert_rule_id
    "alertRuleTemplate"   = var.alert_rule_template
    "detectedDateTime"    = var.detected_date_time
    "displayName"         = var.display_name
    "lastUpdatedDateTime" = var.last_updated_date_time
    "@odata.type"         = var.odata_type
    "resolvedDateTime"    = var.resolved_date_time
    "severity"            = var.severity
    "status"              = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/monitoring/alertRecords"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
