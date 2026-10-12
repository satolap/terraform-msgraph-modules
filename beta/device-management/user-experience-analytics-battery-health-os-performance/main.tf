# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeDevices"                    = var.active_devices
    "averageBatteryAgeInDays"          = var.average_battery_age_in_days
    "averageEstimatedRuntimeInMinutes" = var.average_estimated_runtime_in_minutes
    "averageMaxCapacityPercentage"     = var.average_max_capacity_percentage
    "meanFullBatteryDrainCount"        = var.mean_full_battery_drain_count
    "medianEstimatedRuntimeInMinutes"  = var.median_estimated_runtime_in_minutes
    "medianFullBatteryDrainCount"      = var.median_full_battery_drain_count
    "medianMaxCapacityPercentage"      = var.median_max_capacity_percentage
    "@odata.type"                      = var.odata_type
    "osBatteryHealthScore"             = var.os_battery_health_score
    "osBuildNumber"                    = var.os_build_number
    "osHealthStatus"                   = var.os_health_status
    "osVersion"                        = var.os_version
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsBatteryHealthOsPerformance"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
