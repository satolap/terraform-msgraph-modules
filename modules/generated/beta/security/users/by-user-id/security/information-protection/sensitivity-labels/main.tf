# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "color"          = var.color
    "contentFormats" = (var.content_formats == null ? null : [for item0 in var.content_formats : item0 if item0 != null])
    "description"    = var.description
    "hasProtection"  = var.has_protection
    "isActive"       = var.is_active
    "isAppliable"    = var.is_appliable
    "name"           = var.name
    "@odata.type"    = var.odata_type
    "parent"         = var.parent
    "sensitivity"    = var.sensitivity
    "tooltip"        = var.tooltip
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/security/informationProtection/sensitivityLabels"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
