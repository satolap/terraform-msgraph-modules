# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"     = var.odata_type
    "settingInstance" = (var.setting_instance == null ? null : { for key0, value0 in { "@odata.type" = var.setting_instance["odata_type"], "settingDefinitionId" = var.setting_instance["settingDefinitionId"], "settingInstanceTemplateReference" = var.setting_instance["settingInstanceTemplateReference"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/targetedManagedAppConfigurations/${urlencode(var.targeted_managed_app_configuration_id)}/settings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
