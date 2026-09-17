locals {
  body = {
    displayName = var.display_name
    description = var.description
    state       = var.state
    catalogType = var.catalog_type
  }
}

resource "msgraph_resource" "catalog" {
  url         = "identityGovernance/entitlementManagement/catalogs"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    display_name = "displayName"
    state        = "state"
    catalog_type = "catalogType"
  }
}
