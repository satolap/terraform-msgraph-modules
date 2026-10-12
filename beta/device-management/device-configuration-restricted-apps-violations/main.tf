# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceConfigurationId"   = var.device_configuration_id
    "deviceConfigurationName" = var.device_configuration_name
    "deviceName"              = var.device_name
    "managedDeviceId"         = var.managed_device_id
    "@odata.type"             = var.odata_type
    "platformType"            = var.platform_type
    "restrictedApps"          = (var.restricted_apps == null ? null : [for item0 in var.restricted_apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appId" = item0["appId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "restrictedAppsState"     = var.restricted_apps_state
    "userId"                  = var.user_id
    "userName"                = var.user_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceConfigurationRestrictedAppsViolations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
