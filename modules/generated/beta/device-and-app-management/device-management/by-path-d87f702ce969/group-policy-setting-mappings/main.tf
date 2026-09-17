# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "admxSettingDefinitionId"   = var.admx_setting_definition_id
    "childIdList"               = (var.child_id_list == null ? null : [for item0 in var.child_id_list : item0 if item0 != null])
    "intuneSettingDefinitionId" = var.intune_setting_definition_id
    "intuneSettingUriList"      = (var.intune_setting_uri_list == null ? null : [for item0 in var.intune_setting_uri_list : item0 if item0 != null])
    "isMdmSupported"            = var.is_mdm_supported
    "mdmCspName"                = var.mdm_csp_name
    "mdmMinimumOSVersion"       = var.mdm_minimum_os_version
    "mdmSettingUri"             = var.mdm_setting_uri
    "mdmSupportedState"         = var.mdm_supported_state
    "@odata.type"               = var.odata_type
    "parentId"                  = var.parent_id
    "settingCategory"           = var.setting_category
    "settingDisplayName"        = var.setting_display_name
    "settingDisplayValue"       = var.setting_display_value
    "settingDisplayValueType"   = var.setting_display_value_type
    "settingName"               = var.setting_name
    "settingScope"              = var.setting_scope
    "settingType"               = var.setting_type
    "settingValue"              = var.setting_value
    "settingValueDisplayUnits"  = var.setting_value_display_units
    "settingValueType"          = var.setting_value_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyMigrationReports/${urlencode(var.group_policy_migration_report_id)}/groupPolicySettingMappings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
