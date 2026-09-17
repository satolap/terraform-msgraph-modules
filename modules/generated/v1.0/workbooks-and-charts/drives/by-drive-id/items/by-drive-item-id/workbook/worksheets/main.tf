# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "name"        = var.name
    "@odata.type" = var.odata_type
    "pivotTables" = (var.pivot_tables == null ? null : [for item0 in var.pivot_tables : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "position"    = var.position
    "visibility"  = var.visibility
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items/${urlencode(var.drive_item_id)}/workbook/worksheets"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
