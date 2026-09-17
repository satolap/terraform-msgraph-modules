# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "dataType"        = var.data_type
    "deletedDateTime" = var.deleted_date_time
    "isMultiValued"   = var.is_multi_valued
    "name"            = var.name
    "@odata.type"     = var.odata_type
    "targetObjects"   = (var.target_objects == null ? null : [for item0 in var.target_objects : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "applications/${urlencode(var.application_id)}/extensionProperties"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
