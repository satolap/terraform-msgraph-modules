# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"     = var.odata_type
    "settingInsights" = (var.setting_insights == null ? null : [for item0 in var.setting_insights : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingDefinitionId" = item0["settingDefinitionId"], "settingInsight" = item0["settingInsight"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/templateInsights"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
