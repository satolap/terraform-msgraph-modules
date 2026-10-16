# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"         = var.display_name
    "hasRequiredSetting"  = var.has_required_setting
    "@odata.type"         = var.odata_type
    "recommendedSettings" = (var.recommended_settings == null ? null : [for item0 in var.recommended_settings : item0 if item0 != null])
    "settingDefinitions"  = (var.setting_definitions == null ? null : [for item0 in var.setting_definitions : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/templates/${urlencode(var.device_management_template_id)}/migratableTo/${urlencode(var.device_management_template_id1)}/categories"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
