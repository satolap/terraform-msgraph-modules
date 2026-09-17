# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowUnmanagedSettings"            = var.allow_unmanaged_settings
    "baseId"                            = var.base_id
    "description"                       = var.description
    "disableEntraGroupPolicyAssignment" = var.disable_entra_group_policy_assignment
    "displayName"                       = var.display_name
    "displayVersion"                    = var.display_version
    "lifecycleState"                    = var.lifecycle_state
    "@odata.type"                       = var.odata_type
    "platforms"                         = var.platforms
    "settingTemplates"                  = (var.setting_templates == null ? null : [for item0 in var.setting_templates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingDefinitions" = (item0["settingDefinitions"] == null ? null : [for item2 in item0["settingDefinitions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "accessTypes" = item2["accessTypes"], "applicability" = item2["applicability"], "baseUri" = item2["baseUri"], "categoryId" = item2["categoryId"], "description" = item2["description"], "displayName" = item2["displayName"], "helpText" = item2["helpText"], "infoUrls" = (item2["infoUrls"] == null ? null : [for item4 in item2["infoUrls"] : item4 if item4 != null]), "keywords" = (item2["keywords"] == null ? null : [for item4 in item2["keywords"] : item4 if item4 != null]), "name" = item2["name"], "occurrence" = item2["occurrence"], "offsetUri" = item2["offsetUri"], "referredSettingInformationList" = (item2["referredSettingInformationList"] == null ? null : [for item4 in item2["referredSettingInformationList"] : item4 if item4 != null]), "riskLevel" = item2["riskLevel"], "rootDefinitionId" = item2["rootDefinitionId"], "settingUsage" = item2["settingUsage"], "uxBehavior" = item2["uxBehavior"], "version" = item2["version"], "visibility" = item2["visibility"] } : key3 => value3 if value3 != null }) if item2 != null]), "settingInstanceTemplate" = (item0["settingInstanceTemplate"] == null ? null : { for key2, value2 in { "@odata.type" = item0["settingInstanceTemplate"]["odata_type"], "isRequired" = item0["settingInstanceTemplate"]["isRequired"], "settingDefinitionId" = item0["settingInstanceTemplate"]["settingDefinitionId"], "settingInstanceTemplateId" = item0["settingInstanceTemplate"]["settingInstanceTemplateId"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "technologies"                      = var.technologies
    "templateFamily"                    = var.template_family
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/configurationPolicyTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
