# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "collectionIdentifier" = var.collection_identifier
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "hierarchyIdentifier"  = var.hierarchy_identifier
    "hierarchyName"        = var.hierarchy_name
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/configManagerCollections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
