# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"             = var.address
    "bookingPageSettings" = var.booking_page_settings
    "businessHours"       = (var.business_hours == null ? null : [for item0 in var.business_hours : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "day" = item0["day"], "timeSlots" = (item0["timeSlots"] == null ? null : [for item2 in item0["timeSlots"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "endTime" = item2["endTime"], "startTime" = item2["startTime"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "businessType"        = var.business_type
    "createdDateTime"     = var.created_date_time
    "defaultCurrencyIso"  = var.default_currency_iso
    "displayName"         = var.display_name
    "email"               = var.email
    "languageTag"         = var.language_tag
    "lastUpdatedDateTime" = var.last_updated_date_time
    "@odata.type"         = var.odata_type
    "phone"               = var.phone
    "schedulingPolicy"    = var.scheduling_policy
    "webSiteUrl"          = var.web_site_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/bookingBusinesses"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
