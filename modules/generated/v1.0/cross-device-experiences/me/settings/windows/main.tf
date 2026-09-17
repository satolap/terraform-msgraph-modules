# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "instances"       = (var.instances == null ? null : [for item0 in var.instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "expirationDateTime" = item0["expirationDateTime"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "payload" = item0["payload"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"     = var.odata_type
    "payloadType"     = var.payload_type
    "settingType"     = var.setting_type
    "windowsDeviceId" = var.windows_device_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/settings/windows"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
