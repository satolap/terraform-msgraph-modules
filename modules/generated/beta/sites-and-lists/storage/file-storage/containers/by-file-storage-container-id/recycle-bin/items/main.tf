# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdByUser"       = var.created_by_user
    "deletedDateTime"     = var.deleted_date_time
    "deletedFromLocation" = var.deleted_from_location
    "description"         = var.description
    "lastModifiedByUser"  = var.last_modified_by_user
    "name"                = var.name
    "@odata.type"         = var.odata_type
    "parentReference"     = var.parent_reference
    "size"                = var.size
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containers/${urlencode(var.file_storage_container_id)}/recycleBin/items"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
