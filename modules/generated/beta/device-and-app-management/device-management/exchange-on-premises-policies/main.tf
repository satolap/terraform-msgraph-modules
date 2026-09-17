# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessRules"               = (var.access_rules == null ? null : [for item0 in var.access_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessLevel" = item0["accessLevel"], "deviceClass" = item0["deviceClass"] } : key1 => value1 if value1 != null }) if item0 != null])
    "conditionalAccessSettings" = var.conditional_access_settings
    "defaultAccessLevel"        = var.default_access_level
    "knownDeviceClasses"        = (var.known_device_classes == null ? null : [for item0 in var.known_device_classes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "notificationContent"       = var.notification_content
    "@odata.type"               = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/exchangeOnPremisesPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
