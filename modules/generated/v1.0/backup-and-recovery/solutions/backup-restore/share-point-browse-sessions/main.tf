# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "backupSizeInBytes"    = var.backup_size_in_bytes
    "createdDateTime"      = var.created_date_time
    "error"                = var.error
    "expirationDateTime"   = var.expiration_date_time
    "@odata.type"          = var.odata_type
    "restorePointDateTime" = var.restore_point_date_time
    "restorePointId"       = var.restore_point_id
    "siteId"               = var.site_id
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/sharePointBrowseSessions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
