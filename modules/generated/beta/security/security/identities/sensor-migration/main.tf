# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime" = var.created_date_time
    "displayName"     = var.display_name
    "domainName"      = var.domain_name
    "version"         = var.graph_version
    "healthStatus"    = var.health_status
    "migrationState"  = var.migration_state
    "@odata.type"     = var.odata_type
    "sensorType"      = var.sensor_type
    "serviceStatus"   = var.service_status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/identities/sensorMigration"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
