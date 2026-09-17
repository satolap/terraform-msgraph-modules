# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageResourceScope" = var.access_package_resource_scope
    "createdBy"                  = var.created_by
    "createdDateTime"            = var.created_date_time
    "modifiedBy"                 = var.modified_by
    "modifiedDateTime"           = var.modified_date_time
    "@odata.type"                = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackages/${urlencode(var.access_package_id)}/accessPackageResourceRoleScopes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
