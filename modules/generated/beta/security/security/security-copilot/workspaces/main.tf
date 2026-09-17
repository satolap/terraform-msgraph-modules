# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName" = var.display_name
    "@odata.type" = var.odata_type
    "plugins"     = (var.plugins == null ? null : [for item0 in var.plugins : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "authorization" = item0["authorization"], "catalogScope" = item0["catalogScope"], "category" = item0["category"], "description" = item0["description"], "displayName" = item0["displayName"], "isEnabled" = item0["isEnabled"], "name" = item0["name"], "previewState" = item0["previewState"], "settings" = (item0["settings"] == null ? null : [for item2 in item0["settings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "acceptableValues" = (item2["acceptableValues"] == null ? null : [for item4 in item2["acceptableValues"] : item4 if item4 != null]), "defaultValue" = item2["defaultValue"], "description" = item2["description"], "displayType" = item2["displayType"], "hintText" = item2["hintText"], "isRequired" = item2["isRequired"], "label" = item2["label"], "name" = item2["name"], "settingValue" = item2["settingValue"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "supportedAuthTypes" = item0["supportedAuthTypes"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sessions"    = (var.sessions == null ? null : [for item0 in var.sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "prompts" = (item0["prompts"] == null ? null : [for item2 in item0["prompts"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "content" = item2["content"], "createdDateTime" = item2["createdDateTime"], "evaluations" = (item2["evaluations"] == null ? null : [for item4 in item2["evaluations"] : item4 if item4 != null]), "inputs" = item2["inputs"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "skillInputDescriptors" = (item2["skillInputDescriptors"] == null ? null : [for item4 in item2["skillInputDescriptors"] : item4 if item4 != null]), "skillName" = item2["skillName"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/securityCopilot/workspaces"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
