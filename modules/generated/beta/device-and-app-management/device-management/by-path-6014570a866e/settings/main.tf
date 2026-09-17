# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "definitionId" = var.definition_id
    "@odata.type"  = var.odata_type
    "valueJson"    = var.value_json
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/intents/${urlencode(var.device_management_intent_id)}/categories/${urlencode(var.device_management_intent_setting_category_id)}/settings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
