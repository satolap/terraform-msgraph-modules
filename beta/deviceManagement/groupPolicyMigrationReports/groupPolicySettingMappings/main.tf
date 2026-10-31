# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "admxSettingDefinitionId"   = var.admxSettingDefinitionId
    "childIdList"               = (var.childIdList == null ? null : [for item0 in var.childIdList : item0 if item0 != null])
    "intuneSettingDefinitionId" = var.intuneSettingDefinitionId
    "intuneSettingUriList"      = (var.intuneSettingUriList == null ? null : [for item0 in var.intuneSettingUriList : item0 if item0 != null])
    "isMdmSupported"            = var.isMdmSupported
    "mdmCspName"                = var.mdmCspName
    "mdmMinimumOSVersion"       = var.mdmMinimumOSVersion
    "mdmSettingUri"             = var.mdmSettingUri
    "mdmSupportedState"         = var.mdmSupportedState
    "@odata.type"               = var.odata_type
    "parentId"                  = var.parentId
    "settingCategory"           = var.settingCategory
    "settingDisplayName"        = var.settingDisplayName
    "settingDisplayValue"       = var.settingDisplayValue
    "settingDisplayValueType"   = var.settingDisplayValueType
    "settingName"               = var.settingName
    "settingScope"              = var.settingScope
    "settingType"               = var.settingType
    "settingValue"              = var.settingValue
    "settingValueDisplayUnits"  = var.settingValueDisplayUnits
    "settingValueType"          = var.settingValueType
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyMigrationReports/${urlencode(var.groupPolicyMigrationReport-id)}/groupPolicySettingMappings"
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
