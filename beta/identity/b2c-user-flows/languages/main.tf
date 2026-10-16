# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "defaultPages"   = (var.default_pages == null ? null : [for item0 in var.default_pages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isEnabled"      = var.is_enabled
    "@odata.type"    = var.odata_type
    "overridesPages" = (var.overrides_pages == null ? null : [for item0 in var.overrides_pages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/b2cUserFlows/${urlencode(var.b2c_identity_user_flow_id)}/languages"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
