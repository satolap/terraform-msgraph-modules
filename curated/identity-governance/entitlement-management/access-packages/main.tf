locals {
  body = {
    displayName = var.display_name
    description = var.description
    isHidden    = var.is_hidden
    catalog = {
      id = var.catalog_id
    }
  }
}

resource "msgraph_resource" "access_package" {
  url         = "identityGovernance/entitlementManagement/accessPackages"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    display_name = "displayName"
    is_hidden    = "isHidden"
  }
}
