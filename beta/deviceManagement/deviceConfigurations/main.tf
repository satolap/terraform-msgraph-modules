# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"                                 = var.odata_type
    "assignments"                                 = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "intent" = item0["intent"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                             = var.createdDateTime
    "description"                                 = var.description
    "deviceManagementApplicabilityRuleDeviceMode" = (var.deviceManagementApplicabilityRuleDeviceMode == null ? null : { for key0, value0 in { "@odata.type" = var.deviceManagementApplicabilityRuleDeviceMode["odata_type"], "deviceMode" = var.deviceManagementApplicabilityRuleDeviceMode["deviceMode"], "name" = var.deviceManagementApplicabilityRuleDeviceMode["name"], "ruleType" = var.deviceManagementApplicabilityRuleDeviceMode["ruleType"] } : key0 => value0 if value0 != null })
    "deviceManagementApplicabilityRuleOsEdition"  = (var.deviceManagementApplicabilityRuleOsEdition == null ? null : { for key0, value0 in { "@odata.type" = var.deviceManagementApplicabilityRuleOsEdition["odata_type"], "name" = var.deviceManagementApplicabilityRuleOsEdition["name"], "osEditionTypes" = (var.deviceManagementApplicabilityRuleOsEdition["osEditionTypes"] == null ? null : [for item1 in var.deviceManagementApplicabilityRuleOsEdition["osEditionTypes"] : item1 if item1 != null]), "ruleType" = var.deviceManagementApplicabilityRuleOsEdition["ruleType"] } : key0 => value0 if value0 != null })
    "deviceManagementApplicabilityRuleOsVersion"  = (var.deviceManagementApplicabilityRuleOsVersion == null ? null : { for key0, value0 in { "@odata.type" = var.deviceManagementApplicabilityRuleOsVersion["odata_type"], "maxOSVersion" = var.deviceManagementApplicabilityRuleOsVersion["maxOSVersion"], "minOSVersion" = var.deviceManagementApplicabilityRuleOsVersion["minOSVersion"], "name" = var.deviceManagementApplicabilityRuleOsVersion["name"], "ruleType" = var.deviceManagementApplicabilityRuleOsVersion["ruleType"] } : key0 => value0 if value0 != null })
    "deviceSettingStateSummaries"                 = (var.deviceSettingStateSummaries == null ? null : [for item0 in var.deviceSettingStateSummaries : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "compliantDeviceCount" = item0["compliantDeviceCount"], "conflictDeviceCount" = item0["conflictDeviceCount"], "errorDeviceCount" = item0["errorDeviceCount"], "instancePath" = item0["instancePath"], "nonCompliantDeviceCount" = item0["nonCompliantDeviceCount"], "notApplicableDeviceCount" = item0["notApplicableDeviceCount"], "remediatedDeviceCount" = item0["remediatedDeviceCount"], "settingName" = item0["settingName"], "unknownDeviceCount" = item0["unknownDeviceCount"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceStatusOverview"                        = var.deviceStatusOverview
    "deviceStatuses"                              = (var.deviceStatuses == null ? null : [for item0 in var.deviceStatuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "complianceGracePeriodExpirationDateTime" = item0["complianceGracePeriodExpirationDateTime"], "deviceDisplayName" = item0["deviceDisplayName"], "deviceModel" = item0["deviceModel"], "lastReportedDateTime" = item0["lastReportedDateTime"], "platform" = item0["platform"], "status" = item0["status"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                                 = var.displayName
    "version"                                     = var.graph_version
    "groupAssignments"                            = (var.groupAssignments == null ? null : [for item0 in var.groupAssignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceConfiguration" = item0["deviceConfiguration"], "excludeGroup" = item0["excludeGroup"], "targetGroupId" = item0["targetGroupId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime"                        = var.lastModifiedDateTime
    "roleScopeTagIds"                             = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "userStatusOverview"                          = var.userStatusOverview
    "userStatuses"                                = (var.userStatuses == null ? null : [for item0 in var.userStatuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "devicesCount" = item0["devicesCount"], "lastReportedDateTime" = item0["lastReportedDateTime"], "status" = item0["status"], "userDisplayName" = item0["userDisplayName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "deviceSettingStateSummaries", "deviceStatusOverview", "deviceStatuses", "groupAssignments", "userStatusOverview", "userStatuses"], name)])]))))] } : null

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
