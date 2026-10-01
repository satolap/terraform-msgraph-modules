# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"     = var.display_name
    "isEnabled"       = var.is_enabled
    "rolePermissions" = (var.role_permissions == null ? null : [for item0 in var.role_permissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedResourceActions" = (item0["allowedResourceActions"] == null ? null : [for item2 in item0["allowedResourceActions"] : item2 if item2 != null]), "condition" = item0["condition"], "excludedResourceActions" = (item0["excludedResourceActions"] == null ? null : [for item2 in item0["excludedResourceActions"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"     = var.description
    "version"         = var.graph_version
    "@odata.type"     = var.odata_type
    "templateId"      = var.template_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/directory/roleDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
