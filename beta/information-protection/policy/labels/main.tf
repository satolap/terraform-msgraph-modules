# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "color"       = var.color
    "description" = var.description
    "isActive"    = var.is_active
    "name"        = var.name
    "@odata.type" = var.odata_type
    "parent"      = var.parent
    "sensitivity" = var.sensitivity
    "tooltip"     = var.tooltip
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "informationProtection/policy/labels"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
