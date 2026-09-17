# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"              = var.created_by
    "createdDateTime"        = var.created_date_time
    "destinationType"        = var.destination_type
    "displayName"            = var.display_name
    "error"                  = var.error
    "lastModifiedBy"         = var.last_modified_by
    "lastModifiedDateTime"   = var.last_modified_date_time
    "@odata.type"            = var.odata_type
    "protectionTimePeriod"   = var.protection_time_period
    "protectionUnitIds"      = (var.protection_unit_ids == null ? null : [for item0 in var.protection_unit_ids : item0 if item0 != null])
    "restorePointPreference" = var.restore_point_preference
    "siteIds"                = (var.site_ids == null ? null : [for item0 in var.site_ids : item0 if item0 != null])
    "siteWebUrls"            = (var.site_web_urls == null ? null : [for item0 in var.site_web_urls : item0 if item0 != null])
    "status"                 = var.status
    "tags"                   = var.tags
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/sharePointRestoreSessions/${urlencode(var.share_point_restore_session_id)}/siteRestoreArtifactsBulkAdditionRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
