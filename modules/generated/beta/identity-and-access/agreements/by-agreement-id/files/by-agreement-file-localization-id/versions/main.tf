# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime" = var.created_date_time
    "displayName"     = var.display_name
    "isMajorVersion"  = var.is_major_version
    "@odata.type"     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "agreements/${urlencode(var.agreement_id)}/files/${urlencode(var.agreement_file_localization_id)}/versions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
