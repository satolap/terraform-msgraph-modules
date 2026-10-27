# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "chat"                   = var.chat
    "consentedPermissionSet" = (var.consented_permission_set == null ? null : { for key0, value0 in { "@odata.type" = var.consented_permission_set["odata_type"], "resourceSpecificPermissions" = (var.consented_permission_set["resourceSpecificPermissions"] == null ? null : [for item1 in var.consented_permission_set["resourceSpecificPermissions"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "permissionType" = item1["permissionType"], "permissionValue" = item1["permissionValue"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "@odata.type"            = var.odata_type
    "scopeInfo"              = var.scope_info
    "teamsApp"               = var.teams_app
    "teamsAppDefinition"     = var.teams_app_definition
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/teamwork/installedApps"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["chat", "teamsApp", "teamsAppDefinition"], name)])]))))] } : null

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
