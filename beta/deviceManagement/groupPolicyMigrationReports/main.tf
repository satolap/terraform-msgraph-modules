# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"                  = var.createdDateTime
    "displayName"                      = var.displayName
    "groupPolicyCreatedDateTime"       = var.groupPolicyCreatedDateTime
    "groupPolicyLastModifiedDateTime"  = var.groupPolicyLastModifiedDateTime
    "groupPolicyObjectId"              = var.groupPolicyObjectId
    "groupPolicySettingMappings"       = (var.groupPolicySettingMappings == null ? null : [for item0 in var.groupPolicySettingMappings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "admxSettingDefinitionId" = item0["admxSettingDefinitionId"], "childIdList" = (item0["childIdList"] == null ? null : [for item2 in item0["childIdList"] : item2 if item2 != null]), "intuneSettingDefinitionId" = item0["intuneSettingDefinitionId"], "intuneSettingUriList" = (item0["intuneSettingUriList"] == null ? null : [for item2 in item0["intuneSettingUriList"] : item2 if item2 != null]), "isMdmSupported" = item0["isMdmSupported"], "mdmCspName" = item0["mdmCspName"], "mdmMinimumOSVersion" = item0["mdmMinimumOSVersion"], "mdmSettingUri" = item0["mdmSettingUri"], "mdmSupportedState" = item0["mdmSupportedState"], "parentId" = item0["parentId"], "settingCategory" = item0["settingCategory"], "settingDisplayName" = item0["settingDisplayName"], "settingDisplayValue" = item0["settingDisplayValue"], "settingDisplayValueType" = item0["settingDisplayValueType"], "settingName" = item0["settingName"], "settingScope" = item0["settingScope"], "settingType" = item0["settingType"], "settingValue" = item0["settingValue"], "settingValueDisplayUnits" = item0["settingValueDisplayUnits"], "settingValueType" = item0["settingValueType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime"             = var.lastModifiedDateTime
    "migrationReadiness"               = var.migrationReadiness
    "@odata.type"                      = var.odata_type
    "ouDistinguishedName"              = var.ouDistinguishedName
    "roleScopeTagIds"                  = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "supportedSettingsCount"           = var.supportedSettingsCount
    "supportedSettingsPercent"         = var.supportedSettingsPercent
    "targetedInActiveDirectory"        = var.targetedInActiveDirectory
    "totalSettingsCount"               = var.totalSettingsCount
    "unsupportedGroupPolicyExtensions" = (var.unsupportedGroupPolicyExtensions == null ? null : [for item0 in var.unsupportedGroupPolicyExtensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "extensionType" = item0["extensionType"], "namespaceUrl" = item0["namespaceUrl"], "nodeName" = item0["nodeName"], "settingScope" = item0["settingScope"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyMigrationReports"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["groupPolicySettingMappings", "unsupportedGroupPolicyExtensions"], name)])]))))] } : null

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
