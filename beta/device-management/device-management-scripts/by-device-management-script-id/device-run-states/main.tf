# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "errorCode"               = var.error_code
    "errorDescription"        = var.error_description
    "lastStateUpdateDateTime" = var.last_state_update_date_time
    "managedDevice"           = var.managed_device
    "@odata.type"             = var.odata_type
    "resultMessage"           = var.result_message
    "runState"                = var.run_state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceManagementScripts/${urlencode(var.device_management_script_id)}/deviceRunStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
