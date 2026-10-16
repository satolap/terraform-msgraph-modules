# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "highlightFirstColumn" = var.highlight_first_column
    "highlightLastColumn"  = var.highlight_last_column
    "name"                 = var.name
    "@odata.type"          = var.odata_type
    "showBandedColumns"    = var.show_banded_columns
    "showBandedRows"       = var.show_banded_rows
    "showFilterButton"     = var.show_filter_button
    "showHeaders"          = var.show_headers
    "showTotals"           = var.show_totals
    "style"                = var.style
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items/${urlencode(var.drive_item_id)}/workbook/tables"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
