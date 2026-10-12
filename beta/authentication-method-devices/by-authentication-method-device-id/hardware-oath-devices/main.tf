# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignTo"              = var.assign_to
    "assignedTo"            = var.assigned_to
    "displayName"           = var.display_name
    "hardwareOathDevices"   = (var.hardware_oath_devices == null ? null : [for item0 in var.hardware_oath_devices : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignTo" = item0["assignTo"], "assignedTo" = item0["assignedTo"], "displayName" = item0["displayName"], "hardwareOathDevices" = (item0["hardwareOathDevices"] == null ? null : [for item2 in item0["hardwareOathDevices"] : item2 if item2 != null]), "hashFunction" = item0["hashFunction"], "manufacturer" = item0["manufacturer"], "model" = item0["model"], "secretKey" = item0["secretKey"], "serialNumber" = item0["serialNumber"], "status" = item0["status"], "timeIntervalInSeconds" = item0["timeIntervalInSeconds"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hashFunction"          = var.hash_function
    "manufacturer"          = var.manufacturer
    "model"                 = var.model
    "@odata.type"           = var.odata_type
    "secretKey"             = var.secret_key
    "serialNumber"          = var.serial_number
    "status"                = var.status
    "timeIntervalInSeconds" = var.time_interval_in_seconds
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "authenticationMethodDevices/${urlencode(var.authentication_method_device_id)}/hardwareOathDevices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
