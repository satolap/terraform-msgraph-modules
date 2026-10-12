# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addresses"           = (var.addresses == null ? null : [for item0 in var.addresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "city" = item0["city"], "countryOrRegion" = item0["countryOrRegion"], "postOfficeBox" = item0["postOfficeBox"], "postalCode" = item0["postalCode"], "state" = item0["state"], "street" = item0["street"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"     = var.created_date_time
    "displayName"         = var.display_name
    "emailAddress"        = var.email_address
    "lastUpdatedDateTime" = var.last_updated_date_time
    "@odata.type"         = var.odata_type
    "phones"              = (var.phones == null ? null : [for item0 in var.phones : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "number" = item0["number"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "bookingBusinesses/${urlencode(var.booking_business_id)}/customers"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
