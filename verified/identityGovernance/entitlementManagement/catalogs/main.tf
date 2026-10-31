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
      displayName = var.displayName
      description = var.description
      state       = var.state
    },
    var.isExternallyVisible == null ? {} : { isExternallyVisible = var.isExternallyVisible },
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
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.displayName))
      error_message = "displayName \"${var.displayName}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set displayName to a value that matches, or change name_pattern."
    }
  }
}
