# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "blueScreenCount"            = var.blue_screen_count
    "bootTotalDurationInSeconds" = var.boot_total_duration_in_seconds
    "deviceId"                   = var.device_id
    "deviceMake"                 = var.device_make
    "deviceModel"                = var.device_model
    "deviceName"                 = var.device_name
    "healthStatus"               = var.health_status
    "lastUpdatedDateTime"        = var.last_updated_date_time
    "@odata.type"                = var.odata_type
    "osVersion"                  = var.os_version
    "primaryDiskType"            = var.primary_disk_type
    "restartCount"               = var.restart_count
    "startupPerformanceScore"    = var.startup_performance_score
    "tenantDisplayName"          = var.tenant_display_name
    "tenantId"                   = var.tenant_id
    "topProcesses"               = var.top_processes
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/deviceHealthStatuses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
