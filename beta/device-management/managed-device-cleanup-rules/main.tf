# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"                            = var.description
    "deviceCleanupRulePlatformType"          = var.device_cleanup_rule_platform_type
    "deviceInactivityBeforeRetirementInDays" = var.device_inactivity_before_retirement_in_days
    "displayName"                            = var.display_name
    "@odata.type"                            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/managedDeviceCleanupRules"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
