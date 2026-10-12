# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "error"            = (var.error == null ? null : { for key0, value0 in { "@odata.type" = var.error["odata_type"], "code" = var.error["code"], "innerError" = var.error["innerError"], "message" = var.error["message"] } : key0 => value0 if value0 != null })
    "@odata.type"      = var.odata_type
    "resourceLocation" = var.resource_location
    "status"           = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items/${urlencode(var.drive_item_id)}/workbook/operations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
