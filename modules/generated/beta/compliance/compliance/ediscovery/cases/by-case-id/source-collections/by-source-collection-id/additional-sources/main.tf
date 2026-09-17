# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"       = var.created_by
    "createdDateTime" = var.created_date_time
    "displayName"     = var.display_name
    "holdStatus"      = var.hold_status
    "@odata.type"     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "compliance/ediscovery/cases/${urlencode(var.case_id)}/sourceCollections/${urlencode(var.source_collection_id)}/additionalSources"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
