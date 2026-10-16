# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "expirationDateTime" = var.expiration_date_time
    "@odata.type"        = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/lists/${urlencode(var.list_id)}/items/${urlencode(var.list_item_id)}/permissions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
