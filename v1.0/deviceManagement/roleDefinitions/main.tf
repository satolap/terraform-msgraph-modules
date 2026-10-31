# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"     = var.description
    "displayName"     = var.displayName
    "isBuiltIn"       = var.isBuiltIn
    "@odata.type"     = var.odata_type
    "roleAssignments" = (var.roleAssignments == null ? null : [for item0 in var.roleAssignments : item0 if item0 != null])
    "rolePermissions" = (var.rolePermissions == null ? null : [for item0 in var.rolePermissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "resourceActions" = (item0["resourceActions"] == null ? null : [for item2 in item0["resourceActions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowedResourceActions" = (item2["allowedResourceActions"] == null ? null : [for item4 in item2["allowedResourceActions"] : item4 if item4 != null]), "notAllowedResourceActions" = (item2["notAllowedResourceActions"] == null ? null : [for item4 in item2["notAllowedResourceActions"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/roleDefinitions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["roleAssignments"], name)])]))))] } : null

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
