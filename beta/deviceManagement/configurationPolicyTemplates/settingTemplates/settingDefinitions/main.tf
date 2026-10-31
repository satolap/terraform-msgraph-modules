# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessTypes"                    = var.accessTypes
    "applicability"                  = var.applicability
    "baseUri"                        = var.baseUri
    "categoryId"                     = var.categoryId
    "description"                    = var.description
    "displayName"                    = var.displayName
    "version"                        = var.graph_version
    "helpText"                       = var.helpText
    "infoUrls"                       = (var.infoUrls == null ? null : [for item0 in var.infoUrls : item0 if item0 != null])
    "keywords"                       = (var.keywords == null ? null : [for item0 in var.keywords : item0 if item0 != null])
    "name"                           = var.name
    "occurrence"                     = (var.occurrence == null ? null : { for key0, value0 in { "@odata.type" = var.occurrence["odata_type"], "maxDeviceOccurrence" = var.occurrence["maxDeviceOccurrence"], "minDeviceOccurrence" = var.occurrence["minDeviceOccurrence"] } : key0 => value0 if value0 != null })
    "@odata.type"                    = var.odata_type
    "offsetUri"                      = var.offsetUri
    "referredSettingInformationList" = (var.referredSettingInformationList == null ? null : [for item0 in var.referredSettingInformationList : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingDefinitionId" = item0["settingDefinitionId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "riskLevel"                      = var.riskLevel
    "rootDefinitionId"               = var.rootDefinitionId
    "settingUsage"                   = var.settingUsage
    "uxBehavior"                     = var.uxBehavior
    "visibility"                     = var.visibility
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/configurationPolicyTemplates/${urlencode(var.deviceManagementConfigurationPolicyTemplate-id)}/settingTemplates/${urlencode(var.deviceManagementConfigurationSettingTemplate-id)}/settingDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
