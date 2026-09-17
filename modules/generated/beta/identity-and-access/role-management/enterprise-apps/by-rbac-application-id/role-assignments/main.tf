# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appScopeId"              = var.app_scope_id
    "condition"               = var.condition
    "directoryScopeId"        = var.directory_scope_id
    "@odata.type"             = var.odata_type
    "principalId"             = var.principal_id
    "principalOrganizationId" = var.principal_organization_id
    "resourceScope"           = var.resource_scope
    "roleDefinition"          = var.role_definition
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/enterpriseApps/${urlencode(var.rbac_application_id)}/roleAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
