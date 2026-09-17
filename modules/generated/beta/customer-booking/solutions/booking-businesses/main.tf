# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"             = var.address
    "bookingPageSettings" = var.booking_page_settings
    "businessHours"       = (var.business_hours == null ? null : [for item0 in var.business_hours : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "day" = item0["day"], "timeSlots" = (item0["timeSlots"] == null ? null : [for item2 in item0["timeSlots"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "end" = item2["end"], "start" = item2["start"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "businessType"        = var.business_type
    "createdDateTime"     = var.created_date_time
    "customQuestions"     = (var.custom_questions == null ? null : [for item0 in var.custom_questions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "answerInputType" = item0["answerInputType"], "answerOptions" = (item0["answerOptions"] == null ? null : [for item2 in item0["answerOptions"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "lastUpdatedDateTime" = item0["lastUpdatedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
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
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
