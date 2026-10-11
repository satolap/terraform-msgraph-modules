locals {
  # isExternallyVisible is sent only when set, so that a caller who does not set
  # it keeps the same request body as before the input existed.
  body = merge(
    {
      displayName = var.display_name
      description = var.description
      state       = var.state
      catalogType = var.catalog_type
    },
    var.is_externally_visible == null ? {} : { isExternallyVisible = var.is_externally_visible },
  )
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
