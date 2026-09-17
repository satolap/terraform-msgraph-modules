# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contentType" = item0["contentType"], "isInline" = item0["isInline"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "name" = item0["name"], "size" = item0["size"] } : key1 => value1 if value1 != null }) if item0 != null])
    "body"                          = var.body
    "categories"                    = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "createdDateTime"               = var.created_date_time
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime"          = var.last_modified_date_time
    "multiValueExtendedProperties"  = (var.multi_value_extended_properties == null ? null : [for item0 in var.multi_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = (item0["value"] == null ? null : [for item2 in item0["value"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "singleValueExtendedProperties" = (var.single_value_extended_properties == null ? null : [for item0 in var.single_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "subject"                       = var.subject
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/notes"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
