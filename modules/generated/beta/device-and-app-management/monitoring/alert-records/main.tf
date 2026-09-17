# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertImpact"         = var.alert_impact
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
  url                     = "monitoring/alertRecords"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
