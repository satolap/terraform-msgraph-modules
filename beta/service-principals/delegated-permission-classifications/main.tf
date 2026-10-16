# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "classification" = var.classification
    "@odata.type"    = var.odata_type
    "permissionId"   = var.permission_id
    "permissionName" = var.permission_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "servicePrincipals/${urlencode(var.service_principal_id)}/delegatedPermissionClassifications"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
