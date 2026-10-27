# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appDetail"            = (var.app_detail == null ? null : { for key0, value0 in { "@odata.type" = var.app_detail["odata_type"], "commandLineArguments" = var.app_detail["commandLineArguments"], "filePath" = var.app_detail["filePath"], "iconIndex" = var.app_detail["iconIndex"], "iconPath" = var.app_detail["iconPath"] } : key0 => value0 if value0 != null })
    "appStatus"            = var.app_status
    "availableToUser"      = var.available_to_user
    "description"          = var.description
    "displayName"          = var.display_name
    "@odata.type"          = var.odata_type
    "provisioningPolicyId" = var.provisioning_policy_id
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
