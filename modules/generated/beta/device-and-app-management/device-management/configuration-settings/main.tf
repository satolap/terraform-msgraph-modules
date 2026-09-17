# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessTypes"                    = var.access_types
    "applicability"                  = var.applicability
    "baseUri"                        = var.base_uri
    "categoryId"                     = var.category_id
    "description"                    = var.description
    "displayName"                    = var.display_name
    "version"                        = var.graph_version
    "helpText"                       = var.help_text
    "infoUrls"                       = (var.info_urls == null ? null : [for item0 in var.info_urls : item0 if item0 != null])
    "keywords"                       = (var.keywords == null ? null : [for item0 in var.keywords : item0 if item0 != null])
    "name"                           = var.name
    "occurrence"                     = var.occurrence
    "@odata.type"                    = var.odata_type
    "offsetUri"                      = var.offset_uri
    "referredSettingInformationList" = (var.referred_setting_information_list == null ? null : [for item0 in var.referred_setting_information_list : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingDefinitionId" = item0["settingDefinitionId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "riskLevel"                      = var.risk_level
    "rootDefinitionId"               = var.root_definition_id
    "settingUsage"                   = var.setting_usage
    "uxBehavior"                     = var.ux_behavior
    "visibility"                     = var.visibility
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/configurationSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
