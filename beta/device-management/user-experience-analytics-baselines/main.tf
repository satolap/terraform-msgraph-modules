# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appHealthMetrics"             = var.app_health_metrics
    "batteryHealthMetrics"         = var.battery_health_metrics
    "bestPracticesMetrics"         = var.best_practices_metrics
    "createdDateTime"              = var.created_date_time
    "deviceBootPerformanceMetrics" = var.device_boot_performance_metrics
    "displayName"                  = var.display_name
    "isBuiltIn"                    = var.is_built_in
    "@odata.type"                  = var.odata_type
    "rebootAnalyticsMetrics"       = var.reboot_analytics_metrics
    "resourcePerformanceMetrics"   = var.resource_performance_metrics
    "workFromAnywhereMetrics"      = var.work_from_anywhere_metrics
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsBaselines"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
