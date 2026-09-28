# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appVersion"               = var.app_version
    "deviceHealth"             = (var.device_health == null ? null : { for key0, value0 in { "@odata.type" = var.device_health["odata_type"], "lastConnectionTime" = var.device_health["lastConnectionTime"] } : key0 => value0 if value0 != null })
    "displayName"              = var.display_name
    "fullyQualifiedDomainName" = var.fully_qualified_domain_name
    "location"                 = (var.location == null ? null : { for key0, value0 in { "@odata.type" = var.location["odata_type"], "altitudeInMeters" = var.location["altitudeInMeters"], "building" = var.location["building"], "city" = var.location["city"], "countryOrRegion" = var.location["countryOrRegion"], "floor" = var.location["floor"], "floorDescription" = var.location["floorDescription"], "floorNumber" = var.location["floorNumber"], "latitude" = var.location["latitude"], "longitude" = var.location["longitude"], "organization" = (var.location["organization"] == null ? null : [for item1 in var.location["organization"] : item1 if item1 != null]), "postalCode" = var.location["postalCode"], "roomDescription" = var.location["roomDescription"], "roomName" = var.location["roomName"], "roomNumber" = var.location["roomNumber"], "site" = var.location["site"], "stateOrProvince" = var.location["stateOrProvince"], "streetAddress" = var.location["streetAddress"], "subdivision" = (var.location["subdivision"] == null ? null : [for item1 in var.location["subdivision"] : item1 if item1 != null]), "subunit" = (var.location["subunit"] == null ? null : [for item1 in var.location["subunit"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "name"                     = var.name
    "@odata.type"              = var.odata_type
    "operatingSystem"          = var.operating_system
    "registeredDateTime"       = var.registered_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/connectors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
