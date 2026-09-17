# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appFriendlyName"     = var.app_friendly_name
    "appName"             = var.app_name
    "appPublisher"        = var.app_publisher
    "appVersion"          = var.app_version
    "deviceId"            = var.device_id
    "deviceManufacturer"  = var.device_manufacturer
    "deviceModel"         = var.device_model
    "deviceName"          = var.device_name
    "healthStatus"        = var.health_status
    "isLatestUsedVersion" = var.is_latest_used_version
    "isMostUsedVersion"   = var.is_most_used_version
    "lastUpdatedDateTime" = var.last_updated_date_time
    "@odata.type"         = var.odata_type
    "tenantDisplayName"   = var.tenant_display_name
    "tenantId"            = var.tenant_id
    "totalAppCrashCount"  = var.total_app_crash_count
    "totalAppFreezeCount" = var.total_app_freeze_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/deviceAppPerformances"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
