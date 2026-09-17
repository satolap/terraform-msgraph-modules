# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "body"                = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "format" = var.body["format"] } : key0 => value0 if value0 != null })
    "createdDateTime"     = var.created_date_time
    "imageUrl"            = var.image_url
    "indicators"          = (var.indicators == null ? null : [for item0 in var.indicators : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "artifact" = (item0["artifact"] == null ? null : { for key2, value2 in { "@odata.type" = item0["artifact"]["odata_type"] } : key2 => value2 if value2 != null }), "source" = item0["source"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isFeatured"          = var.is_featured
    "lastUpdatedDateTime" = var.last_updated_date_time
    "@odata.type"         = var.odata_type
    "summary"             = (var.summary == null ? null : { for key0, value0 in { "@odata.type" = var.summary["odata_type"], "content" = var.summary["content"], "format" = var.summary["format"] } : key0 => value0 if value0 != null })
    "tags"                = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "title"               = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatIntelligence/articles"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
