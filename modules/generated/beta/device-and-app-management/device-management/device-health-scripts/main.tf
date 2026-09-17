# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                 = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "runRemediationScript" = item0["runRemediationScript"], "runSchedule" = item0["runSchedule"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                 = var.description
    "detectionScriptContent"      = var.detection_script_content
    "detectionScriptParameters"   = (var.detection_script_parameters == null ? null : [for item0 in var.detection_script_parameters : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applyDefaultValueWhenNotAssigned" = item0["applyDefaultValueWhenNotAssigned"], "description" = item0["description"], "isRequired" = item0["isRequired"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deviceHealthScriptType"      = var.device_health_script_type
    "deviceRunStates"             = (var.device_run_states == null ? null : [for item0 in var.device_run_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignmentFilterIds" = (item0["assignmentFilterIds"] == null ? null : [for item2 in item0["assignmentFilterIds"] : item2 if item2 != null]), "detectionState" = item0["detectionState"], "expectedStateUpdateDateTime" = item0["expectedStateUpdateDateTime"], "lastStateUpdateDateTime" = item0["lastStateUpdateDateTime"], "lastSyncDateTime" = item0["lastSyncDateTime"], "managedDevice" = item0["managedDevice"], "postRemediationDetectionScriptError" = item0["postRemediationDetectionScriptError"], "postRemediationDetectionScriptOutput" = item0["postRemediationDetectionScriptOutput"], "preRemediationDetectionScriptError" = item0["preRemediationDetectionScriptError"], "preRemediationDetectionScriptOutput" = item0["preRemediationDetectionScriptOutput"], "remediationScriptError" = item0["remediationScriptError"], "remediationState" = item0["remediationState"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                 = var.display_name
    "enforceSignatureCheck"       = var.enforce_signature_check
    "version"                     = var.graph_version
    "highestAvailableVersion"     = var.highest_available_version
    "@odata.type"                 = var.odata_type
    "publisher"                   = var.publisher
    "remediationScriptContent"    = var.remediation_script_content
    "remediationScriptParameters" = (var.remediation_script_parameters == null ? null : [for item0 in var.remediation_script_parameters : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applyDefaultValueWhenNotAssigned" = item0["applyDefaultValueWhenNotAssigned"], "description" = item0["description"], "isRequired" = item0["isRequired"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "roleScopeTagIds"             = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "runAs32Bit"                  = var.run_as32_bit
    "runAsAccount"                = var.run_as_account
    "runSummary"                  = var.run_summary
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceHealthScripts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
