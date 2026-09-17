# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceRunStates"    = (var.device_run_states == null ? null : [for item0 in var.device_run_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "errorCode" = item0["errorCode"], "errorDescription" = item0["errorDescription"], "lastStateUpdateDateTime" = item0["lastStateUpdateDateTime"], "managedDevice" = item0["managedDevice"], "resultMessage" = item0["resultMessage"], "runState" = item0["runState"] } : key1 => value1 if value1 != null }) if item0 != null])
    "errorDeviceCount"   = var.error_device_count
    "@odata.type"        = var.odata_type
    "successDeviceCount" = var.success_device_count
    "userPrincipalName"  = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceShellScripts/${urlencode(var.device_shell_script_id)}/userRunStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
