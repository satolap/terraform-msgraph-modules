# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"  = var.description
    "deviceId"     = var.device_id
    "displayName"  = var.display_name
    "ipV4Address"  = var.ip_v4_address
    "ipV6Address"  = var.ip_v6_address
    "macAddress"   = var.mac_address
    "manufacturer" = var.manufacturer
    "@odata.type"  = var.odata_type
    "placeId"      = var.place_id
    "sensors"      = (var.sensors == null ? null : [for item0 in var.sensors : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "placeId" = item0["placeId"], "sensorId" = item0["sensorId"], "sensorType" = item0["sensorType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tags"         = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "workplace/sensorDevices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
