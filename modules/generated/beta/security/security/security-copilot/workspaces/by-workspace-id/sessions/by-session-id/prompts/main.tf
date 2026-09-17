# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"               = var.content
    "createdDateTime"       = var.created_date_time
    "evaluations"           = (var.evaluations == null ? null : [for item0 in var.evaluations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "completedDateTime" = item0["completedDateTime"], "createdDateTime" = item0["createdDateTime"], "executionCount" = item0["executionCount"], "isCancelled" = item0["isCancelled"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "result" = item0["result"], "runStartDateTime" = item0["runStartDateTime"], "state" = item0["state"] } : key1 => value1 if value1 != null }) if item0 != null])
    "inputs"                = var.inputs
    "lastModifiedDateTime"  = var.last_modified_date_time
    "@odata.type"           = var.odata_type
    "skillInputDescriptors" = (var.skill_input_descriptors == null ? null : [for item0 in var.skill_input_descriptors : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "defaultValue" = item0["defaultValue"], "description" = item0["description"], "isRequired" = item0["isRequired"], "name" = item0["name"], "placeholderValue" = item0["placeholderValue"], "type" = (item0["type"] == null ? null : { for key2, value2 in { "@odata.type" = item0["type"]["odata_type"], "name" = item0["type"]["name"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "skillName"             = var.skill_name
    "type"                  = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/securityCopilot/workspaces/${urlencode(var.workspace_id)}/sessions/${urlencode(var.session_id)}/prompts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
