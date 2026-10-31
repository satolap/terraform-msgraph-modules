# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceRunStates"    = (var.deviceRunStates == null ? null : [for item0 in var.deviceRunStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "errorCode" = item0["errorCode"], "errorDescription" = item0["errorDescription"], "lastStateUpdateDateTime" = item0["lastStateUpdateDateTime"], "managedDevice" = item0["managedDevice"], "resultMessage" = item0["resultMessage"], "runState" = item0["runState"] } : key1 => value1 if value1 != null }) if item0 != null])
    "errorDeviceCount"   = var.errorDeviceCount
    "@odata.type"        = var.odata_type
    "successDeviceCount" = var.successDeviceCount
    "userPrincipalName"  = var.userPrincipalName
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceShellScripts/${urlencode(var.deviceShellScript-id)}/userRunStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["deviceRunStates"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
