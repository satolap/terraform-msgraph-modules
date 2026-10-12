# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeDevices"          = var.active_devices
    "appDisplayName"         = var.app_display_name
    "appName"                = var.app_name
    "appPublisher"           = var.app_publisher
    "batteryUsagePercentage" = var.battery_usage_percentage
    "isForegroundApp"        = var.is_foreground_app
    "@odata.type"            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsBatteryHealthAppImpact"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
