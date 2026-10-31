# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                 = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "runRemediationScript" = item0["runRemediationScript"], "runSchedule" = item0["runSchedule"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                 = var.description
    "detectionScriptContent"      = var.detectionScriptContent
    "detectionScriptParameters"   = (var.detectionScriptParameters == null ? null : [for item0 in var.detectionScriptParameters : item0 if item0 != null])
    "deviceHealthScriptType"      = var.deviceHealthScriptType
    "deviceRunStates"             = (var.deviceRunStates == null ? null : [for item0 in var.deviceRunStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignmentFilterIds" = (item0["assignmentFilterIds"] == null ? null : [for item2 in item0["assignmentFilterIds"] : item2 if item2 != null]), "detectionState" = item0["detectionState"], "expectedStateUpdateDateTime" = item0["expectedStateUpdateDateTime"], "lastStateUpdateDateTime" = item0["lastStateUpdateDateTime"], "lastSyncDateTime" = item0["lastSyncDateTime"], "managedDevice" = item0["managedDevice"], "postRemediationDetectionScriptError" = item0["postRemediationDetectionScriptError"], "postRemediationDetectionScriptOutput" = item0["postRemediationDetectionScriptOutput"], "preRemediationDetectionScriptError" = item0["preRemediationDetectionScriptError"], "preRemediationDetectionScriptOutput" = item0["preRemediationDetectionScriptOutput"], "remediationScriptError" = item0["remediationScriptError"], "remediationState" = item0["remediationState"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                 = var.displayName
    "enforceSignatureCheck"       = var.enforceSignatureCheck
    "version"                     = var.graph_version
    "highestAvailableVersion"     = var.highestAvailableVersion
    "@odata.type"                 = var.odata_type
    "publisher"                   = var.publisher
    "remediationScriptContent"    = var.remediationScriptContent
    "remediationScriptParameters" = (var.remediationScriptParameters == null ? null : [for item0 in var.remediationScriptParameters : item0 if item0 != null])
    "roleScopeTagIds"             = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "runAs32Bit"                  = var.runAs32Bit
    "runAsAccount"                = var.runAsAccount
    "runSummary"                  = var.runSummary
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceHealthScripts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "deviceRunStates", "runSummary"], name)])]))))] } : null

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
