# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "compliantCount"     = var.compliant_count
    "conflictCount"      = var.conflict_count
    "errorCount"         = var.error_count
    "nonCompliantCount"  = var.non_compliant_count
    "notApplicableCount" = var.not_applicable_count
    "@odata.type"        = var.odata_type
    "remediatedCount"    = var.remediated_count
    "settingName"        = var.setting_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/intents/${urlencode(var.device_management_intent_id)}/deviceSettingStateSummaries"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
