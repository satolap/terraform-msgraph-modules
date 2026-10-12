# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"           = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"           = var.description
    "deviceRunStates"       = (var.device_run_states == null ? null : [for item0 in var.device_run_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "errorCode" = item0["errorCode"], "errorDescription" = item0["errorDescription"], "lastStateUpdateDateTime" = item0["lastStateUpdateDateTime"], "managedDevice" = item0["managedDevice"], "resultMessage" = item0["resultMessage"], "runState" = item0["runState"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"           = var.display_name
    "enforceSignatureCheck" = var.enforce_signature_check
    "fileName"              = var.file_name
    "groupAssignments"      = (var.group_assignments == null ? null : [for item0 in var.group_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "targetGroupId" = item0["targetGroupId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"           = var.odata_type
    "roleScopeTagIds"       = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "runAs32Bit"            = var.run_as32_bit
    "runAsAccount"          = var.run_as_account
    "runSummary"            = var.run_summary
    "scriptContent"         = var.script_content
    "userRunStates"         = (var.user_run_states == null ? null : [for item0 in var.user_run_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceRunStates" = (item0["deviceRunStates"] == null ? null : [for item2 in item0["deviceRunStates"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "errorCode" = item2["errorCode"], "errorDescription" = item2["errorDescription"], "lastStateUpdateDateTime" = item2["lastStateUpdateDateTime"], "managedDevice" = item2["managedDevice"], "resultMessage" = item2["resultMessage"], "runState" = item2["runState"] } : key3 => value3 if value3 != null }) if item2 != null]), "errorDeviceCount" = item0["errorDeviceCount"], "successDeviceCount" = item0["successDeviceCount"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceManagementScripts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
