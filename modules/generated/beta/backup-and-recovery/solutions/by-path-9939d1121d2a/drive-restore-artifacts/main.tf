# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completionDateTime" = var.completion_date_time
    "destinationType"    = var.destination_type
    "error"              = (var.error == null ? null : { for key0, value0 in { "@odata.type" = var.error["odata_type"], "code" = var.error["code"], "details" = (var.error["details"] == null ? null : [for item1 in var.error["details"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "code" = item1["code"], "message" = item1["message"], "target" = item1["target"] } : key2 => value2 if value2 != null }) if item1 != null]), "innerError" = (var.error["innerError"] == null ? null : { for key1, value1 in { "@odata.type" = var.error["innerError"]["odata_type"], "code" = var.error["innerError"]["code"], "details" = (var.error["innerError"]["details"] == null ? null : [for item2 in var.error["innerError"]["details"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "code" = item2["code"], "message" = item2["message"], "target" = item2["target"] } : key3 => value3 if value3 != null }) if item2 != null]), "message" = var.error["innerError"]["message"], "target" = var.error["innerError"]["target"] } : key1 => value1 if value1 != null }), "message" = var.error["message"], "target" = var.error["target"] } : key0 => value0 if value0 != null })
    "@odata.type"        = var.odata_type
    "restorePoint"       = var.restore_point
    "restoredSiteId"     = var.restored_site_id
    "startDateTime"      = var.start_date_time
    "status"             = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/oneDriveForBusinessRestoreSessions/${urlencode(var.one_drive_for_business_restore_session_id)}/driveRestoreArtifacts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
