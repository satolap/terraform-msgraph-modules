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

# Microsoft Learn documents the catalog relationship as required on create and
# read-only afterwards, and the update operation lists only displayName,
# description and isHidden. A change of catalog_id therefore replaces the
# access package instead of sending a PATCH that cannot move it. The new
# package is created in the new catalog before the old one is deleted, so that
# resources which reference the id, such as assignment policies and resource
# role scopes, can follow it first. The catalog_id is compared as written: the
# PATCH of any other change never carries the catalog, because the provider
# sends only the keys whose values changed.
resource "terraform_data" "immutable" {
  input = {
    catalog_id = var.catalog_id
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

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [terraform_data.immutable]
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
  }
}
