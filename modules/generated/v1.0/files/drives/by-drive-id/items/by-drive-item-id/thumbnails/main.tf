# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "source"      = (var.graph_source == null ? null : { for key0, value0 in { "@odata.type" = var.graph_source["odata_type"], "content" = var.graph_source["content"], "height" = var.graph_source["height"], "sourceItemId" = var.graph_source["sourceItemId"], "url" = var.graph_source["url"], "width" = var.graph_source["width"] } : key0 => value0 if value0 != null })
    "large"       = (var.large == null ? null : { for key0, value0 in { "@odata.type" = var.large["odata_type"], "content" = var.large["content"], "height" = var.large["height"], "sourceItemId" = var.large["sourceItemId"], "url" = var.large["url"], "width" = var.large["width"] } : key0 => value0 if value0 != null })
    "medium"      = (var.medium == null ? null : { for key0, value0 in { "@odata.type" = var.medium["odata_type"], "content" = var.medium["content"], "height" = var.medium["height"], "sourceItemId" = var.medium["sourceItemId"], "url" = var.medium["url"], "width" = var.medium["width"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
    "small"       = (var.small == null ? null : { for key0, value0 in { "@odata.type" = var.small["odata_type"], "content" = var.small["content"], "height" = var.small["height"], "sourceItemId" = var.small["sourceItemId"], "url" = var.small["url"], "width" = var.small["width"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items/${urlencode(var.drive_item_id)}/thumbnails"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
