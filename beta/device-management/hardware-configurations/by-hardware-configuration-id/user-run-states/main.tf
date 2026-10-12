# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "errorDeviceCount"         = var.error_device_count
    "failedDeviceCount"        = var.failed_device_count
    "lastStateUpdateDateTime"  = var.last_state_update_date_time
    "notApplicableDeviceCount" = var.not_applicable_device_count
    "@odata.type"              = var.odata_type
    "pendingDeviceCount"       = var.pending_device_count
    "successfulDeviceCount"    = var.successful_device_count
    "unknownDeviceCount"       = var.unknown_device_count
    "upn"                      = var.upn
    "userEmail"                = var.user_email
    "userName"                 = var.user_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/hardwareConfigurations/${urlencode(var.hardware_configuration_id)}/userRunStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
