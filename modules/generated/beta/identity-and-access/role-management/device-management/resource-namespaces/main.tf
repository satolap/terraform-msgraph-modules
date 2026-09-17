# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "name"            = var.name
    "@odata.type"     = var.odata_type
    "resourceActions" = (var.resource_actions == null ? null : [for item0 in var.resource_actions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actionVerb" = item0["actionVerb"], "authenticationContext" = item0["authenticationContext"], "authenticationContextId" = item0["authenticationContextId"], "description" = item0["description"], "isAuthenticationContextSettable" = item0["isAuthenticationContextSettable"], "name" = item0["name"], "resourceScope" = item0["resourceScope"], "resourceScopeId" = item0["resourceScopeId"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/deviceManagement/resourceNamespaces"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
