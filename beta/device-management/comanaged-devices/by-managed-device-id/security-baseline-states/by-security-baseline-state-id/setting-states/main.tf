# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "contributingPolicies" = (var.contributing_policies == null ? null : [for item0 in var.contributing_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "sourceId" = item0["sourceId"], "sourceType" = item0["sourceType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "errorCode"            = var.error_code
    "@odata.type"          = var.odata_type
    "settingCategoryId"    = var.setting_category_id
    "settingCategoryName"  = var.setting_category_name
    "settingId"            = var.setting_id
    "settingName"          = var.setting_name
    "sourcePolicies"       = (var.source_policies == null ? null : [for item0 in var.source_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "id" = item0["id"], "sourceType" = item0["sourceType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "state"                = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/comanagedDevices/${urlencode(var.managed_device_id)}/securityBaselineStates/${urlencode(var.security_baseline_state_id)}/settingStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
