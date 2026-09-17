# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "columns"     = (var.columns == null ? null : [for item0 in var.columns : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "webparts" = (item0["webparts"] == null ? null : [for item2 in item0["webparts"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]), "width" = item0["width"] } : key1 => value1 if value1 != null }) if item0 != null])
    "emphasis"    = var.emphasis
    "layout"      = var.layout
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/pageTemplates/${urlencode(var.page_template_id)}/canvasLayout/horizontalSections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
