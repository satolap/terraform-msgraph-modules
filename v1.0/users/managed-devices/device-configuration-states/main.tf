# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"   = var.display_name
    "version"       = var.graph_version
    "@odata.type"   = var.odata_type
    "platformType"  = var.platform_type
    "settingCount"  = var.setting_count
    "settingStates" = (var.setting_states == null ? null : [for item0 in var.setting_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "currentValue" = item0["currentValue"], "errorCode" = item0["errorCode"], "errorDescription" = item0["errorDescription"], "instanceDisplayName" = item0["instanceDisplayName"], "setting" = item0["setting"], "settingName" = item0["settingName"], "sources" = (item0["sources"] == null ? null : [for item2 in item0["sources"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "id" = item2["id"], "sourceType" = item2["sourceType"] } : key3 => value3 if value3 != null }) if item2 != null]), "state" = item0["state"], "userEmail" = item0["userEmail"], "userId" = item0["userId"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "state"         = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/managedDevices/${urlencode(var.managed_device_id)}/deviceConfigurationStates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
