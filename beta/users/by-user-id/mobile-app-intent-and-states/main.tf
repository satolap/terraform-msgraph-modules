# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "managedDeviceIdentifier" = var.managed_device_identifier
    "mobileAppList"           = (var.mobile_app_list == null ? null : [for item0 in var.mobile_app_list : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicationId" = item0["applicationId"], "displayName" = item0["displayName"], "displayVersion" = item0["displayVersion"], "installState" = item0["installState"], "mobileAppIntent" = item0["mobileAppIntent"], "supportedDeviceTypes" = (item0["supportedDeviceTypes"] == null ? null : [for item2 in item0["supportedDeviceTypes"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "maximumOperatingSystemVersion" = item2["maximumOperatingSystemVersion"], "minimumOperatingSystemVersion" = item2["minimumOperatingSystemVersion"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"             = var.odata_type
    "userId"                  = var.user_id_2
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/mobileAppIntentAndStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
