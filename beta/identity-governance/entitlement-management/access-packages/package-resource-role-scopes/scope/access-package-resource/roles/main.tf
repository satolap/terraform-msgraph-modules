# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageResource" = var.access_package_resource
    "description"           = var.description
    "displayName"           = var.display_name
    "@odata.type"           = var.odata_type
    "originId"              = var.origin_id
    "originSystem"          = var.origin_system
    "type"                  = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackages/${urlencode(var.access_package_id)}/accessPackageResourceRoleScopes/${urlencode(var.access_package_resource_role_scope_id)}/accessPackageResourceScope/accessPackageResource/accessPackageResourceRoles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
