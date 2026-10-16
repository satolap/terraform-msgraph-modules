# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"    = var.description
    "displayName"    = var.display_name
    "@odata.type"    = var.odata_type
    "resourceScopes" = (var.resource_scopes == null ? null : [for item0 in var.resource_scopes : item0 if item0 != null])
    "roleDefinition" = var.role_definition
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/roleDefinitions/${urlencode(var.role_definition_id)}/roleAssignments"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
