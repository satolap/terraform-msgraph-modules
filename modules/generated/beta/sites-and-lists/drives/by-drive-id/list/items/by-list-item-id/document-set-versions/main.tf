# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "comment"                   = var.comment
    "createdBy"                 = var.created_by
    "createdDateTime"           = var.created_date_time
    "fields"                    = var.fields
    "items"                     = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "itemId" = item0["itemId"], "title" = item0["title"], "versionId" = item0["versionId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"               = var.odata_type
    "shouldCaptureMinorVersion" = var.should_capture_minor_version
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/list/items/${urlencode(var.list_item_id)}/documentSetVersions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
