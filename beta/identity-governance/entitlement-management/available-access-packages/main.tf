# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"        = var.description
    "displayName"        = var.display_name
    "@odata.type"        = var.odata_type
    "resourceRoleScopes" = (var.resource_role_scopes == null ? null : [for item0 in var.resource_role_scopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessPackageResourceScope" = item0["accessPackageResourceScope"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "modifiedBy" = item0["modifiedBy"], "modifiedDateTime" = item0["modifiedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/availableAccessPackages"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
