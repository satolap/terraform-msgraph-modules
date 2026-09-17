# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "prompts"              = (var.prompts == null ? null : [for item0 in var.prompts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "createdDateTime" = item0["createdDateTime"], "evaluations" = (item0["evaluations"] == null ? null : [for item2 in item0["evaluations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "completedDateTime" = item2["completedDateTime"], "createdDateTime" = item2["createdDateTime"], "executionCount" = item2["executionCount"], "isCancelled" = item2["isCancelled"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "result" = item2["result"], "runStartDateTime" = item2["runStartDateTime"], "state" = item2["state"] } : key3 => value3 if value3 != null }) if item2 != null]), "inputs" = item0["inputs"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "skillInputDescriptors" = (item0["skillInputDescriptors"] == null ? null : [for item2 in item0["skillInputDescriptors"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "defaultValue" = item2["defaultValue"], "description" = item2["description"], "isRequired" = item2["isRequired"], "name" = item2["name"], "placeholderValue" = item2["placeholderValue"], "type" = (item2["type"] == null ? null : { for key4, value4 in { "@odata.type" = item2["type"]["odata_type"], "name" = item2["type"]["name"] } : key4 => value4 if value4 != null }) } : key3 => value3 if value3 != null }) if item2 != null]), "skillName" = item0["skillName"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/securityCopilot/workspaces/${urlencode(var.workspace_id)}/sessions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
