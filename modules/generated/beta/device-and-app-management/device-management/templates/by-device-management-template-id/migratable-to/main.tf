# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "categories"        = (var.categories == null ? null : [for item0 in var.categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "hasRequiredSetting" = item0["hasRequiredSetting"], "recommendedSettings" = (item0["recommendedSettings"] == null ? null : [for item2 in item0["recommendedSettings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "definitionId" = item2["definitionId"], "valueJson" = item2["valueJson"] } : key3 => value3 if value3 != null }) if item2 != null]), "settingDefinitions" = (item0["settingDefinitions"] == null ? null : [for item2 in item0["settingDefinitions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "constraints" = (item2["constraints"] == null ? null : [for item4 in item2["constraints"] : item4 if item4 != null]), "dependencies" = (item2["dependencies"] == null ? null : [for item4 in item2["dependencies"] : item4 if item4 != null]), "description" = item2["description"], "displayName" = item2["displayName"], "documentationUrl" = item2["documentationUrl"], "headerSubtitle" = item2["headerSubtitle"], "headerTitle" = item2["headerTitle"], "isTopLevel" = item2["isTopLevel"], "keywords" = (item2["keywords"] == null ? null : [for item4 in item2["keywords"] : item4 if item4 != null]), "placeholderText" = item2["placeholderText"], "valueType" = item2["valueType"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"       = var.description
    "displayName"       = var.display_name
    "intentCount"       = var.intent_count
    "isDeprecated"      = var.is_deprecated
    "migratableTo"      = (var.migratable_to == null ? null : [for item0 in var.migratable_to : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "hasRequiredSetting" = item2["hasRequiredSetting"], "recommendedSettings" = (item2["recommendedSettings"] == null ? null : [for item4 in item2["recommendedSettings"] : item4 if item4 != null]), "settingDefinitions" = (item2["settingDefinitions"] == null ? null : [for item4 in item2["settingDefinitions"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "intentCount" = item0["intentCount"], "isDeprecated" = item0["isDeprecated"], "migratableTo" = (item0["migratableTo"] == null ? null : [for item2 in item0["migratableTo"] : item2 if item2 != null]), "platformType" = item0["platformType"], "publishedDateTime" = item0["publishedDateTime"], "settings" = (item0["settings"] == null ? null : [for item2 in item0["settings"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "definitionId" = item2["definitionId"], "valueJson" = item2["valueJson"] } : key3 => value3 if value3 != null }) if item2 != null]), "templateSubtype" = item0["templateSubtype"], "templateType" = item0["templateType"], "versionInfo" = item0["versionInfo"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"       = var.odata_type
    "platformType"      = var.platform_type
    "publishedDateTime" = var.published_date_time
    "settings"          = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "definitionId" = item0["definitionId"], "valueJson" = item0["valueJson"] } : key1 => value1 if value1 != null }) if item0 != null])
    "templateSubtype"   = var.template_subtype
    "templateType"      = var.template_type
    "versionInfo"       = var.version_info
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/templates/${urlencode(var.device_management_template_id)}/migratableTo"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
