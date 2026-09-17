# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "credentials"        = (var.credentials == null ? null : [for item0 in var.credentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accountName" = item0["accountName"], "accountSid" = item0["accountSid"], "backupDateTime" = item0["backupDateTime"], "passwordBase64" = item0["passwordBase64"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceName"         = var.device_name
    "lastBackupDateTime" = var.last_backup_date_time
    "@odata.type"        = var.odata_type
    "refreshDateTime"    = var.refresh_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/deviceLocalCredentials"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
