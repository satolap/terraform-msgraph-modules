# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertConfiguration"   = var.alert_configuration
    "alertDefinition"      = var.alert_definition
    "alertDefinitionId"    = var.alert_definition_id
    "alertIncidents"       = (var.alert_incidents == null ? null : [for item0 in var.alert_incidents : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "incidentCount"        = var.incident_count
    "isActive"             = var.is_active
    "lastModifiedDateTime" = var.last_modified_date_time
    "lastScannedDateTime"  = var.last_scanned_date_time
    "@odata.type"          = var.odata_type
    "scopeId"              = var.scope_id
    "scopeType"            = var.scope_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/roleManagementAlerts/alerts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
