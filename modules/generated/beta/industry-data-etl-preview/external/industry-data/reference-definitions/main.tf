# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "code"          = var.code
    "displayName"   = var.display_name
    "isDisabled"    = var.is_disabled
    "@odata.type"   = var.odata_type
    "referenceType" = var.reference_type
    "sortIndex"     = var.sort_index
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/referenceDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
