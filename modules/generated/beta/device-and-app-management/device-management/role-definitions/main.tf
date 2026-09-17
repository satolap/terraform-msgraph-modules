# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"             = var.description
    "displayName"             = var.display_name
    "isBuiltIn"               = var.is_built_in
    "isBuiltInRoleDefinition" = var.is_built_in_role_definition
    "@odata.type"             = var.odata_type
    "permissions"             = (var.permissions == null ? null : [for item0 in var.permissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actions" = (item0["actions"] == null ? null : [for item2 in item0["actions"] : item2 if item2 != null]), "resourceActions" = (item0["resourceActions"] == null ? null : [for item2 in item0["resourceActions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowedResourceActions" = (item2["allowedResourceActions"] == null ? null : [for item4 in item2["allowedResourceActions"] : item4 if item4 != null]), "notAllowedResourceActions" = (item2["notAllowedResourceActions"] == null ? null : [for item4 in item2["notAllowedResourceActions"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "roleAssignments"         = (var.role_assignments == null ? null : [for item0 in var.role_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "resourceScopes" = (item0["resourceScopes"] == null ? null : [for item2 in item0["resourceScopes"] : item2 if item2 != null]), "roleDefinition" = item0["roleDefinition"], "scopeMembers" = (item0["scopeMembers"] == null ? null : [for item2 in item0["scopeMembers"] : item2 if item2 != null]), "scopeType" = item0["scopeType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "rolePermissions"         = (var.role_permissions == null ? null : [for item0 in var.role_permissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actions" = (item0["actions"] == null ? null : [for item2 in item0["actions"] : item2 if item2 != null]), "resourceActions" = (item0["resourceActions"] == null ? null : [for item2 in item0["resourceActions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowedResourceActions" = (item2["allowedResourceActions"] == null ? null : [for item4 in item2["allowedResourceActions"] : item4 if item4 != null]), "notAllowedResourceActions" = (item2["notAllowedResourceActions"] == null ? null : [for item4 in item2["notAllowedResourceActions"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "roleScopeTagIds"         = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/roleDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
