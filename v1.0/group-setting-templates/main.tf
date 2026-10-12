# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime" = var.deleted_date_time
    "description"     = var.description
    "displayName"     = var.display_name
    "@odata.type"     = var.odata_type
    "values"          = (var.values == null ? null : [for item0 in var.values : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "defaultValue" = item0["defaultValue"], "description" = item0["description"], "name" = item0["name"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groupSettingTemplates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
