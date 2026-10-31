# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"         = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "customAttributeName" = var.customAttributeName
    "customAttributeType" = var.customAttributeType
    "description"         = var.description
    "deviceRunStates"     = (var.deviceRunStates == null ? null : [for item0 in var.deviceRunStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "errorCode" = item0["errorCode"], "errorDescription" = item0["errorDescription"], "lastStateUpdateDateTime" = item0["lastStateUpdateDateTime"], "managedDevice" = item0["managedDevice"], "resultMessage" = item0["resultMessage"], "runState" = item0["runState"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"         = var.displayName
    "fileName"            = var.fileName
    "groupAssignments"    = (var.groupAssignments == null ? null : [for item0 in var.groupAssignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "targetGroupId" = item0["targetGroupId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"         = var.odata_type
    "roleScopeTagIds"     = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "runAsAccount"        = var.runAsAccount
    "runSummary"          = var.runSummary
    "scriptContent"       = var.scriptContent
    "userRunStates"       = (var.userRunStates == null ? null : [for item0 in var.userRunStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceRunStates" = (item0["deviceRunStates"] == null ? null : [for item2 in item0["deviceRunStates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "errorCode" = item2["errorCode"], "errorDescription" = item2["errorDescription"], "lastStateUpdateDateTime" = item2["lastStateUpdateDateTime"], "managedDevice" = item2["managedDevice"], "resultMessage" = item2["resultMessage"], "runState" = item2["runState"] } : key3 => value3 if value3 != null }) if item2 != null]), "errorDeviceCount" = item0["errorDeviceCount"], "successDeviceCount" = item0["successDeviceCount"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceCustomAttributeShellScripts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "deviceRunStates", "groupAssignments", "runSummary", "userRunStates"], name)])]))))] } : null

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
