# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appScopeIds"       = (var.app_scope_ids == null ? null : [for item0 in var.app_scope_ids : item0 if item0 != null])
    "condition"         = var.condition
    "description"       = var.description
    "directoryScopeIds" = (var.directory_scope_ids == null ? null : [for item0 in var.directory_scope_ids : item0 if item0 != null])
    "displayName"       = var.display_name
    "@odata.type"       = var.odata_type
    "principalIds"      = (var.principal_ids == null ? null : [for item0 in var.principal_ids : item0 if item0 != null])
    "roleDefinition"    = var.role_definition
    "roleDefinitionId"  = var.role_definition_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/cloudPC/roleAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
