# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"            = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "runRemediationScript" = item0["runRemediationScript"], "runSchedule" = item0["runSchedule"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"            = var.description
    "detectionScriptContent" = var.detection_script_content
    "deviceRunStates"        = (var.device_run_states == null ? null : [for item0 in var.device_run_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "detectionState" = item0["detectionState"], "expectedStateUpdateDateTime" = item0["expectedStateUpdateDateTime"], "lastStateUpdateDateTime" = item0["lastStateUpdateDateTime"], "lastSyncDateTime" = item0["lastSyncDateTime"], "managedDevice" = item0["managedDevice"], "scriptError" = item0["scriptError"], "scriptOutput" = item0["scriptOutput"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"            = var.display_name
    "enforceSignatureCheck"  = var.enforce_signature_check
    "version"                = var.graph_version
    "@odata.type"            = var.odata_type
    "platform"               = var.platform
    "publisher"              = var.publisher
    "roleScopeTagIds"        = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "runAs32Bit"             = var.run_as32_bit
    "runAsAccount"           = var.run_as_account
    "runSummary"             = var.run_summary
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceComplianceScripts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
