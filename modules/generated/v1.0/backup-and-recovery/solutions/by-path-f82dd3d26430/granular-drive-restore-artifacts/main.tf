# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "browseSessionId"      = var.browse_session_id
    "completionDateTime"   = var.completion_date_time
    "directoryObjectId"    = var.directory_object_id
    "@odata.type"          = var.odata_type
    "restorePointDateTime" = var.restore_point_date_time
    "restoredItemKey"      = var.restored_item_key
    "restoredItemPath"     = var.restored_item_path
    "restoredItemWebUrl"   = var.restored_item_web_url
    "startDateTime"        = var.start_date_time
    "status"               = var.status
    "webUrl"               = var.web_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/oneDriveForBusinessRestoreSessions/${urlencode(var.one_drive_for_business_restore_session_id)}/granularDriveRestoreArtifacts"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
