# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"             = (var.address == null ? null : { for key0, value0 in { "@odata.type" = var.address["odata_type"], "city" = var.address["city"], "countryOrRegion" = var.address["countryOrRegion"], "postOfficeBox" = var.address["postOfficeBox"], "postalCode" = var.address["postalCode"], "state" = var.address["state"], "street" = var.address["street"], "type" = var.address["type"] } : key0 => value0 if value0 != null })
    "bookingPageSettings" = (var.booking_page_settings == null ? null : { for key0, value0 in { "@odata.type" = var.booking_page_settings["odata_type"], "accessControl" = var.booking_page_settings["accessControl"], "bookingPageColorCode" = var.booking_page_settings["bookingPageColorCode"], "businessTimeZone" = var.booking_page_settings["businessTimeZone"], "customerConsentMessage" = var.booking_page_settings["customerConsentMessage"], "enforceOneTimePassword" = var.booking_page_settings["enforceOneTimePassword"], "isBusinessLogoDisplayEnabled" = var.booking_page_settings["isBusinessLogoDisplayEnabled"], "isCustomerConsentEnabled" = var.booking_page_settings["isCustomerConsentEnabled"], "isSearchEngineIndexabilityDisabled" = var.booking_page_settings["isSearchEngineIndexabilityDisabled"], "isTimeSlotTimeZoneSetToBusinessTimeZone" = var.booking_page_settings["isTimeSlotTimeZoneSetToBusinessTimeZone"], "privacyPolicyWebUrl" = var.booking_page_settings["privacyPolicyWebUrl"], "termsAndConditionsWebUrl" = var.booking_page_settings["termsAndConditionsWebUrl"] } : key0 => value0 if value0 != null })
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
    "schedulingPolicy"    = (var.scheduling_policy == null ? null : { for key0, value0 in { "@odata.type" = var.scheduling_policy["odata_type"], "allowStaffSelection" = var.scheduling_policy["allowStaffSelection"], "customAvailabilities" = (var.scheduling_policy["customAvailabilities"] == null ? null : [for item1 in var.scheduling_policy["customAvailabilities"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "availabilityType" = item1["availabilityType"], "businessHours" = (item1["businessHours"] == null ? null : [for item3 in item1["businessHours"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "day" = item3["day"], "timeSlots" = item3["timeSlots"] } : key4 => value4 if value4 != null }) if item3 != null]), "endDate" = item1["endDate"], "startDate" = item1["startDate"] } : key2 => value2 if value2 != null }) if item1 != null]), "generalAvailability" = var.scheduling_policy["generalAvailability"], "isMeetingInviteToCustomersEnabled" = var.scheduling_policy["isMeetingInviteToCustomersEnabled"], "maximumAdvance" = var.scheduling_policy["maximumAdvance"], "minimumLeadTime" = var.scheduling_policy["minimumLeadTime"], "sendConfirmationsToOwner" = var.scheduling_policy["sendConfirmationsToOwner"], "timeSlotInterval" = var.scheduling_policy["timeSlotInterval"] } : key0 => value0 if value0 != null })
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
