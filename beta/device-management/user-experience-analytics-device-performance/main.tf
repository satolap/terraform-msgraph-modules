# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "averageBlueScreens"           = var.average_blue_screens
    "averageRestarts"              = var.average_restarts
    "blueScreenCount"              = var.blue_screen_count
    "bootScore"                    = var.boot_score
    "coreBootTimeInMs"             = var.core_boot_time_in_ms
    "coreLoginTimeInMs"            = var.core_login_time_in_ms
    "deviceCount"                  = var.device_count
    "deviceName"                   = var.device_name
    "diskType"                     = var.disk_type
    "groupPolicyBootTimeInMs"      = var.group_policy_boot_time_in_ms
    "groupPolicyLoginTimeInMs"     = var.group_policy_login_time_in_ms
    "healthStatus"                 = var.health_status
    "loginScore"                   = var.login_score
    "manufacturer"                 = var.manufacturer
    "model"                        = var.model
    "modelStartupPerformanceScore" = var.model_startup_performance_score
    "@odata.type"                  = var.odata_type
    "operatingSystemVersion"       = var.operating_system_version
    "responsiveDesktopTimeInMs"    = var.responsive_desktop_time_in_ms
    "restartCount"                 = var.restart_count
    "startupPerformanceScore"      = var.startup_performance_score
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsDevicePerformance"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
