# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"   = var.odata_type
    "performedBy"   = var.performed_by
    "startDateTime" = var.start_date_time
    "type"          = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "connections/${urlencode(var.external_connection_id)}/items/${urlencode(var.external_item_id)}/activities"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
