locals {
  # The body holds only the properties that Microsoft Learn documents for the
  # create request: displayName, description, state and isExternallyVisible.
  # catalogType is not one of them: Learn's create example leaves it out and
  # returns userManaged, and the catalog_type output reads it back. A catalog
  # created while the body still held catalogType plans one in-place update,
  # whose PATCH does not send catalogType and leaves the catalog's type as it
  # is. isExternallyVisible is sent only when set, so that a caller who does
  # not set it keeps the same request body as before the input existed.
  body = merge(
    {
      displayName = var.display_name
      description = var.description
      state       = var.state
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

  lifecycle {
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
  }
}
