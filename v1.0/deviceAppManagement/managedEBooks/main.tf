# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"           = var.odata_type
    "assignments"           = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "installIntent" = item0["installIntent"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"       = var.createdDateTime
    "description"           = var.description
    "deviceStates"          = (var.deviceStates == null ? null : [for item0 in var.deviceStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceId" = item0["deviceId"], "deviceName" = item0["deviceName"], "errorCode" = item0["errorCode"], "installState" = item0["installState"], "lastSyncDateTime" = item0["lastSyncDateTime"], "osDescription" = item0["osDescription"], "osVersion" = item0["osVersion"], "userName" = item0["userName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"           = var.displayName
    "informationUrl"        = var.informationUrl
    "installSummary"        = var.installSummary
    "largeCover"            = (var.largeCover == null ? null : { for key0, value0 in { "@odata.type" = var.largeCover["odata_type"], "type" = var.largeCover["type"], "value" = var.largeCover["value"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"  = var.lastModifiedDateTime
    "privacyInformationUrl" = var.privacyInformationUrl
    "publishedDateTime"     = var.publishedDateTime
    "publisher"             = var.publisher
    "userStateSummary"      = (var.userStateSummary == null ? null : [for item0 in var.userStateSummary : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceStates" = (item0["deviceStates"] == null ? null : [for item2 in item0["deviceStates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deviceId" = item2["deviceId"], "deviceName" = item2["deviceName"], "errorCode" = item2["errorCode"], "installState" = item2["installState"], "lastSyncDateTime" = item2["lastSyncDateTime"], "osDescription" = item2["osDescription"], "osVersion" = item2["osVersion"], "userName" = item2["userName"] } : key3 => value3 if value3 != null }) if item2 != null]), "failedDeviceCount" = item0["failedDeviceCount"], "installedDeviceCount" = item0["installedDeviceCount"], "notInstalledDeviceCount" = item0["notInstalledDeviceCount"], "userName" = item0["userName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/managedEBooks"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "deviceStates", "installSummary", "userStateSummary"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
