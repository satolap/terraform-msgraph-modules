# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authenticationConfiguration" = var.authentication_configuration
    "clientConfiguration"         = var.client_configuration
    "description"                 = var.description
    "displayName"                 = var.display_name
    "endpointConfiguration"       = var.endpoint_configuration
    "@odata.type"                 = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackageCatalogs/${urlencode(var.access_package_catalog_id)}/customAccessPackageWorkflowExtensions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
