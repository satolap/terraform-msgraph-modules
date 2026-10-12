# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"     = var.description
    "displayName"     = var.display_name
    "members"         = (var.members == null ? null : [for item0 in var.members : item0 if item0 != null])
    "@odata.type"     = var.odata_type
    "resourceScopes"  = (var.resource_scopes == null ? null : [for item0 in var.resource_scopes : item0 if item0 != null])
    "roleDefinition"  = var.role_definition
    "roleScopeTagIds" = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "roleScopeTags"   = (var.role_scope_tags == null ? null : [for item0 in var.role_scope_tags : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignments" = (item0["assignments"] == null ? null : [for item2 in item0["assignments"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "target" = item2["target"] } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "scopeMembers"    = (var.scope_members == null ? null : [for item0 in var.scope_members : item0 if item0 != null])
    "scopeType"       = var.scope_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/roleAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
