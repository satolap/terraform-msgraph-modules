# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceStates"            = (var.device_states == null ? null : [for item0 in var.device_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceId" = item0["deviceId"], "deviceName" = item0["deviceName"], "errorCode" = item0["errorCode"], "installState" = item0["installState"], "lastSyncDateTime" = item0["lastSyncDateTime"], "osDescription" = item0["osDescription"], "osVersion" = item0["osVersion"], "userName" = item0["userName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "failedDeviceCount"       = var.failed_device_count
    "installedDeviceCount"    = var.installed_device_count
    "notInstalledDeviceCount" = var.not_installed_device_count
    "@odata.type"             = var.odata_type
    "userName"                = var.user_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/managedEBooks/${urlencode(var.managed_e_book_id)}/userStateSummary"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
