# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"     = var.displayName
    "isEnabled"       = var.isEnabled
    "rolePermissions" = (var.rolePermissions == null ? null : [for item0 in var.rolePermissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedResourceActions" = (item0["allowedResourceActions"] == null ? null : [for item2 in item0["allowedResourceActions"] : item2 if item2 != null]), "condition" = item0["condition"], "excludedResourceActions" = (item0["excludedResourceActions"] == null ? null : [for item2 in item0["excludedResourceActions"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"     = var.description
    "version"         = var.graph_version
    "@odata.type"     = var.odata_type
    "templateId"      = var.templateId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/directory/roleDefinitions"
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
