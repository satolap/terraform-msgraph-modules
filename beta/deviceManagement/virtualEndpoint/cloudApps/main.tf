# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appDetail"            = (var.appDetail == null ? null : { for key0, value0 in { "@odata.type" = var.appDetail["odata_type"], "commandLineArguments" = var.appDetail["commandLineArguments"], "filePath" = var.appDetail["filePath"], "iconIndex" = var.appDetail["iconIndex"], "iconPath" = var.appDetail["iconPath"] } : key0 => value0 if value0 != null })
    "appStatus"            = var.appStatus
    "availableToUser"      = var.availableToUser
    "description"          = var.description
    "displayName"          = var.displayName
    "@odata.type"          = var.odata_type
    "provisioningPolicyId" = var.provisioningPolicyId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/cloudApps"
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
