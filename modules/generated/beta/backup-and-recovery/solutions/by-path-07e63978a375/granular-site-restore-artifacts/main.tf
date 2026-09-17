# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "browseSessionId"      = var.browse_session_id
    "completionDateTime"   = var.completion_date_time
    "destinationType"      = var.destination_type
    "error"                = var.error
    "@odata.type"          = var.odata_type
    "restorePointDateTime" = var.restore_point_date_time
    "restoredItemKey"      = var.restored_item_key
    "restoredItemPath"     = var.restored_item_path
    "restoredItemWebUrl"   = var.restored_item_web_url
    "siteId"               = var.site_id
    "startDateTime"        = var.start_date_time
    "status"               = var.status
    "webUrl"               = var.web_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/sharePointRestoreSessions/${urlencode(var.share_point_restore_session_id)}/granularSiteRestoreArtifacts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
