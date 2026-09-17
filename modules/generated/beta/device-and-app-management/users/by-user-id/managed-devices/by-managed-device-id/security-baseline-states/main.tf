# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                = var.display_name
    "@odata.type"                = var.odata_type
    "securityBaselineTemplateId" = var.security_baseline_template_id
    "settingStates"              = (var.setting_states == null ? null : [for item0 in var.setting_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contributingPolicies" = (item0["contributingPolicies"] == null ? null : [for item2 in item0["contributingPolicies"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "sourceId" = item2["sourceId"], "sourceType" = item2["sourceType"] } : key3 => value3 if value3 != null }) if item2 != null]), "errorCode" = item0["errorCode"], "settingCategoryId" = item0["settingCategoryId"], "settingCategoryName" = item0["settingCategoryName"], "settingId" = item0["settingId"], "settingName" = item0["settingName"], "sourcePolicies" = (item0["sourcePolicies"] == null ? null : [for item2 in item0["sourcePolicies"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "id" = item2["id"], "sourceType" = item2["sourceType"] } : key3 => value3 if value3 != null }) if item2 != null]), "state" = item0["state"] } : key1 => value1 if value1 != null }) if item0 != null])
    "state"                      = var.state
    "userPrincipalName"          = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/managedDevices/${urlencode(var.managed_device_id)}/securityBaselineStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
