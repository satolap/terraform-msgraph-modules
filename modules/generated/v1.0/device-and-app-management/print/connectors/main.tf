# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appVersion"               = var.app_version
    "displayName"              = var.display_name
    "fullyQualifiedDomainName" = var.fully_qualified_domain_name
    "location"                 = (var.location == null ? null : { for key0, value0 in { "@odata.type" = var.location["odata_type"], "altitudeInMeters" = var.location["altitudeInMeters"], "building" = var.location["building"], "city" = var.location["city"], "countryOrRegion" = var.location["countryOrRegion"], "floor" = var.location["floor"], "floorDescription" = var.location["floorDescription"], "latitude" = var.location["latitude"], "longitude" = var.location["longitude"], "organization" = (var.location["organization"] == null ? null : [for item1 in var.location["organization"] : item1 if item1 != null]), "postalCode" = var.location["postalCode"], "roomDescription" = var.location["roomDescription"], "roomName" = var.location["roomName"], "site" = var.location["site"], "stateOrProvince" = var.location["stateOrProvince"], "streetAddress" = var.location["streetAddress"], "subdivision" = (var.location["subdivision"] == null ? null : [for item1 in var.location["subdivision"] : item1 if item1 != null]), "subunit" = (var.location["subunit"] == null ? null : [for item1 in var.location["subunit"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "@odata.type"              = var.odata_type
    "operatingSystem"          = var.operating_system
    "registeredDateTime"       = var.registered_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/connectors"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
