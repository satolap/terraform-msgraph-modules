# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appScopeIds"       = (var.appScopeIds == null ? null : [for item0 in var.appScopeIds : item0 if item0 != null])
    "condition"         = var.condition
    "description"       = var.description
    "directoryScopeIds" = (var.directoryScopeIds == null ? null : [for item0 in var.directoryScopeIds : item0 if item0 != null])
    "displayName"       = var.displayName
    "@odata.type"       = var.odata_type
    "principalIds"      = (var.principalIds == null ? null : [for item0 in var.principalIds : item0 if item0 != null])
    "roleDefinition"    = var.roleDefinition
    "roleDefinitionId"  = var.roleDefinitionId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/deviceManagement/roleAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["roleDefinition"], name)])]))))] } : null

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
