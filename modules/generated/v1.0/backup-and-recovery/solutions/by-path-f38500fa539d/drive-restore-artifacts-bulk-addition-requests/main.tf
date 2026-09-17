# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"              = var.created_by
    "createdDateTime"        = var.created_date_time
    "destinationType"        = var.destination_type
    "directoryObjectIds"     = (var.directory_object_ids == null ? null : [for item0 in var.directory_object_ids : item0 if item0 != null])
    "displayName"            = var.display_name
    "drives"                 = (var.drives == null ? null : [for item0 in var.drives : item0 if item0 != null])
    "error"                  = var.error
    "lastModifiedBy"         = var.last_modified_by
    "lastModifiedDateTime"   = var.last_modified_date_time
    "@odata.type"            = var.odata_type
    "protectionTimePeriod"   = var.protection_time_period
    "protectionUnitIds"      = (var.protection_unit_ids == null ? null : [for item0 in var.protection_unit_ids : item0 if item0 != null])
    "restorePointPreference" = var.restore_point_preference
    "status"                 = var.status
    "tags"                   = var.tags
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/oneDriveForBusinessRestoreSessions/${urlencode(var.one_drive_for_business_restore_session_id)}/driveRestoreArtifactsBulkAdditionRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
