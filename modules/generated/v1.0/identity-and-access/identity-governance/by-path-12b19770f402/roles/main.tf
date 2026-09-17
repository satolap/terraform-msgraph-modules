# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"  = var.description
    "displayName"  = var.display_name
    "@odata.type"  = var.odata_type
    "originId"     = var.origin_id
    "originSystem" = var.origin_system
    "resource"     = var.resource
    "type"         = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/resourceRequests/${urlencode(var.access_package_resource_request_id)}/catalog/resources/${urlencode(var.access_package_resource_id)}/scopes/${urlencode(var.access_package_resource_scope_id)}/resource/roles"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
