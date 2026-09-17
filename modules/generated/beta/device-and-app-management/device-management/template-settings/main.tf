# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"             = var.odata_type
    "settingDefinitions"      = (var.setting_definitions == null ? null : [for item0 in var.setting_definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessTypes" = item0["accessTypes"], "applicability" = item0["applicability"], "baseUri" = item0["baseUri"], "categoryId" = item0["categoryId"], "description" = item0["description"], "displayName" = item0["displayName"], "helpText" = item0["helpText"], "infoUrls" = (item0["infoUrls"] == null ? null : [for item2 in item0["infoUrls"] : item2 if item2 != null]), "keywords" = (item0["keywords"] == null ? null : [for item2 in item0["keywords"] : item2 if item2 != null]), "name" = item0["name"], "occurrence" = item0["occurrence"], "offsetUri" = item0["offsetUri"], "referredSettingInformationList" = (item0["referredSettingInformationList"] == null ? null : [for item2 in item0["referredSettingInformationList"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "settingDefinitionId" = item2["settingDefinitionId"] } : key3 => value3 if value3 != null }) if item2 != null]), "riskLevel" = item0["riskLevel"], "rootDefinitionId" = item0["rootDefinitionId"], "settingUsage" = item0["settingUsage"], "uxBehavior" = item0["uxBehavior"], "version" = item0["version"], "visibility" = item0["visibility"] } : key1 => value1 if value1 != null }) if item0 != null])
    "settingInstanceTemplate" = (var.setting_instance_template == null ? null : { for key0, value0 in { "@odata.type" = var.setting_instance_template["odata_type"], "isRequired" = var.setting_instance_template["isRequired"], "settingDefinitionId" = var.setting_instance_template["settingDefinitionId"], "settingInstanceTemplateId" = var.setting_instance_template["settingInstanceTemplateId"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/templateSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
