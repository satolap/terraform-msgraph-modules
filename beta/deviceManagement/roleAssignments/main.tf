# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"     = var.description
    "displayName"     = var.displayName
    "members"         = (var.members == null ? null : [for item0 in var.members : item0 if item0 != null])
    "@odata.type"     = var.odata_type
    "resourceScopes"  = (var.resourceScopes == null ? null : [for item0 in var.resourceScopes : item0 if item0 != null])
    "roleDefinition"  = var.roleDefinition
    "roleScopeTagIds" = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "roleScopeTags"   = (var.roleScopeTags == null ? null : [for item0 in var.roleScopeTags : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignments" = (item0["assignments"] == null ? null : [for item2 in item0["assignments"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "target" = item2["target"] } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "scopeMembers"    = (var.scopeMembers == null ? null : [for item0 in var.scopeMembers : item0 if item0 != null])
    "scopeType"       = var.scopeType
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/roleAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["roleDefinition", "roleScopeTags"], name)])]))))] } : null

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
