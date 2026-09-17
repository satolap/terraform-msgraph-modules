# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "citationJurisdiction" = var.citation_jurisdiction
    "citationUrl"          = var.citation_url
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "@odata.type"          = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/labels/citations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
