# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"           = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "installIntent" = item0["installIntent"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"       = var.created_date_time
    "description"           = var.description
    "deviceStates"          = (var.device_states == null ? null : [for item0 in var.device_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceId" = item0["deviceId"], "deviceName" = item0["deviceName"], "errorCode" = item0["errorCode"], "installState" = item0["installState"], "lastSyncDateTime" = item0["lastSyncDateTime"], "osDescription" = item0["osDescription"], "osVersion" = item0["osVersion"], "userName" = item0["userName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"           = var.display_name
    "informationUrl"        = var.information_url
    "installSummary"        = var.install_summary
    "largeCover"            = var.large_cover
    "lastModifiedDateTime"  = var.last_modified_date_time
    "@odata.type"           = var.odata_type
    "privacyInformationUrl" = var.privacy_information_url
    "publishedDateTime"     = var.published_date_time
    "publisher"             = var.publisher
    "userStateSummary"      = (var.user_state_summary == null ? null : [for item0 in var.user_state_summary : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceStates" = (item0["deviceStates"] == null ? null : [for item2 in item0["deviceStates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deviceId" = item2["deviceId"], "deviceName" = item2["deviceName"], "errorCode" = item2["errorCode"], "installState" = item2["installState"], "lastSyncDateTime" = item2["lastSyncDateTime"], "osDescription" = item2["osDescription"], "osVersion" = item2["osVersion"], "userName" = item2["userName"] } : key3 => value3 if value3 != null }) if item2 != null]), "failedDeviceCount" = item0["failedDeviceCount"], "installedDeviceCount" = item0["installedDeviceCount"], "notInstalledDeviceCount" = item0["notInstalledDeviceCount"], "userName" = item0["userName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/managedEBooks"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
