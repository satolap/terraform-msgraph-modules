# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"        = var.display_name
    "hasRequiredSetting" = var.has_required_setting
    "@odata.type"        = var.odata_type
    "settingDefinitions" = (var.setting_definitions == null ? null : [for item0 in var.setting_definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "constraints" = (item0["constraints"] == null ? null : [for item2 in item0["constraints"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]), "dependencies" = (item0["dependencies"] == null ? null : [for item2 in item0["dependencies"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "constraints" = (item2["constraints"] == null ? null : [for item4 in item2["constraints"] : item4 if item4 != null]), "definitionId" = item2["definitionId"] } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "documentationUrl" = item0["documentationUrl"], "headerSubtitle" = item0["headerSubtitle"], "headerTitle" = item0["headerTitle"], "isTopLevel" = item0["isTopLevel"], "keywords" = (item0["keywords"] == null ? null : [for item2 in item0["keywords"] : item2 if item2 != null]), "placeholderText" = item0["placeholderText"], "valueType" = item0["valueType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "settings"           = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "definitionId" = item0["definitionId"], "valueJson" = item0["valueJson"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/intents/${urlencode(var.device_management_intent_id)}/categories"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
