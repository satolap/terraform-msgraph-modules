# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionVerb"                      = var.action_verb
    "authenticationContext"           = var.authentication_context
    "authenticationContextId"         = var.authentication_context_id
    "description"                     = var.description
    "isAuthenticationContextSettable" = var.is_authentication_context_settable
    "name"                            = var.name
    "@odata.type"                     = var.odata_type
    "resourceScope"                   = var.resource_scope
    "resourceScopeId"                 = var.resource_scope_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/exchange/resourceNamespaces/${urlencode(var.unified_rbac_resource_namespace_id)}/resourceActions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
