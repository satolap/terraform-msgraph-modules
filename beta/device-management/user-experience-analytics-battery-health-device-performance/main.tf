# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "batteryAgeInDays"          = var.battery_age_in_days
    "deviceBatteriesDetails"    = (var.device_batteries_details == null ? null : [for item0 in var.device_batteries_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "batteryId" = item0["batteryId"], "fullBatteryDrainCount" = item0["fullBatteryDrainCount"], "maxCapacityPercentage" = item0["maxCapacityPercentage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceBatteryCount"        = var.device_battery_count
    "deviceBatteryHealthScore"  = var.device_battery_health_score
    "deviceBatteryTags"         = (var.device_battery_tags == null ? null : [for item0 in var.device_battery_tags : item0 if item0 != null])
    "deviceId"                  = var.device_id
    "deviceManufacturerName"    = var.device_manufacturer_name
    "deviceModelName"           = var.device_model_name
    "deviceName"                = var.device_name
    "estimatedRuntimeInMinutes" = var.estimated_runtime_in_minutes
    "fullBatteryDrainCount"     = var.full_battery_drain_count
    "healthStatus"              = var.health_status
    "manufacturer"              = var.manufacturer
    "maxCapacityPercentage"     = var.max_capacity_percentage
    "model"                     = var.model
    "@odata.type"               = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsBatteryHealthDevicePerformance"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
