# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "errorDeviceCount"         = var.errorDeviceCount
    "failedDeviceCount"        = var.failedDeviceCount
    "lastStateUpdateDateTime"  = var.lastStateUpdateDateTime
    "notApplicableDeviceCount" = var.notApplicableDeviceCount
    "@odata.type"              = var.odata_type
    "pendingDeviceCount"       = var.pendingDeviceCount
    "successfulDeviceCount"    = var.successfulDeviceCount
    "unknownDeviceCount"       = var.unknownDeviceCount
    "upn"                      = var.upn
    "userEmail"                = var.userEmail
    "userName"                 = var.userName
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/hardwareConfigurations/${urlencode(var.hardwareConfiguration-id)}/userRunStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
