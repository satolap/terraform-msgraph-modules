# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "name"        = var.name
    "@odata.type" = var.odata_type
    "values"      = var.values
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items/${urlencode(var.drive_item_id)}/workbook/tables/${urlencode(var.workbook_table_id)}/columns"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
