# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"              = var.content
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "displayName"          = var.display_name
    "isDefaultLangauge"    = var.is_default_langauge
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "locale"               = var.locale
    "@odata.type"          = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/trainings/${urlencode(var.training_id)}/languageDetails"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
