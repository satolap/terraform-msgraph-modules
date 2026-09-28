# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"             = var.odata_type
    "settingDefinitions"      = (var.setting_definitions == null ? null : [for item0 in var.setting_definitions : item0 if item0 != null])
    "settingInstanceTemplate" = var.setting_instance_template
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/configurationPolicyTemplates/${urlencode(var.device_management_configuration_policy_template_id)}/settingTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
