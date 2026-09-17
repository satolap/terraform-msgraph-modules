# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completionDateTime" = var.completion_date_time
    "destinationType"    = var.destination_type
    "error"              = var.error
    "@odata.type"        = var.odata_type
    "restorePoint"       = var.restore_point
    "restoredSiteId"     = var.restored_site_id
    "startDateTime"      = var.start_date_time
    "status"             = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/sharePointRestoreSessions/${urlencode(var.share_point_restore_session_id)}/siteRestoreArtifacts"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
