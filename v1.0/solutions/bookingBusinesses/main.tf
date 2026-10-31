# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"             = (var.address == null ? null : { for key0, value0 in { "@odata.type" = var.address["odata_type"], "city" = var.address["city"], "countryOrRegion" = var.address["countryOrRegion"], "postalCode" = var.address["postalCode"], "state" = var.address["state"], "street" = var.address["street"] } : key0 => value0 if value0 != null })
    "bookingPageSettings" = (var.bookingPageSettings == null ? null : { for key0, value0 in { "@odata.type" = var.bookingPageSettings["odata_type"], "accessControl" = var.bookingPageSettings["accessControl"], "bookingPageColorCode" = var.bookingPageSettings["bookingPageColorCode"], "businessTimeZone" = var.bookingPageSettings["businessTimeZone"], "customerConsentMessage" = var.bookingPageSettings["customerConsentMessage"], "enforceOneTimePassword" = var.bookingPageSettings["enforceOneTimePassword"], "isBusinessLogoDisplayEnabled" = var.bookingPageSettings["isBusinessLogoDisplayEnabled"], "isCustomerConsentEnabled" = var.bookingPageSettings["isCustomerConsentEnabled"], "isSearchEngineIndexabilityDisabled" = var.bookingPageSettings["isSearchEngineIndexabilityDisabled"], "isTimeSlotTimeZoneSetToBusinessTimeZone" = var.bookingPageSettings["isTimeSlotTimeZoneSetToBusinessTimeZone"], "privacyPolicyWebUrl" = var.bookingPageSettings["privacyPolicyWebUrl"], "termsAndConditionsWebUrl" = var.bookingPageSettings["termsAndConditionsWebUrl"] } : key0 => value0 if value0 != null })
    "businessHours"       = (var.businessHours == null ? null : [for item0 in var.businessHours : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "day" = item0["day"], "timeSlots" = (item0["timeSlots"] == null ? null : [for item2 in item0["timeSlots"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "endTime" = item2["endTime"], "startTime" = item2["startTime"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "businessType"        = var.businessType
    "createdDateTime"     = var.createdDateTime
    "defaultCurrencyIso"  = var.defaultCurrencyIso
    "displayName"         = var.displayName
    "email"               = var.email
    "languageTag"         = var.languageTag
    "lastUpdatedDateTime" = var.lastUpdatedDateTime
    "@odata.type"         = var.odata_type
    "phone"               = var.phone
    "schedulingPolicy"    = (var.schedulingPolicy == null ? null : { for key0, value0 in { "@odata.type" = var.schedulingPolicy["odata_type"], "allowStaffSelection" = var.schedulingPolicy["allowStaffSelection"], "customAvailabilities" = (var.schedulingPolicy["customAvailabilities"] == null ? null : [for item1 in var.schedulingPolicy["customAvailabilities"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "availabilityType" = item1["availabilityType"], "businessHours" = (item1["businessHours"] == null ? null : [for item3 in item1["businessHours"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "day" = item3["day"], "timeSlots" = item3["timeSlots"] } : key4 => value4 if value4 != null }) if item3 != null]), "endDate" = item1["endDate"], "startDate" = item1["startDate"] } : key2 => value2 if value2 != null }) if item1 != null]), "generalAvailability" = var.schedulingPolicy["generalAvailability"], "isMeetingInviteToCustomersEnabled" = var.schedulingPolicy["isMeetingInviteToCustomersEnabled"], "maximumAdvance" = var.schedulingPolicy["maximumAdvance"], "minimumLeadTime" = var.schedulingPolicy["minimumLeadTime"], "sendConfirmationsToOwner" = var.schedulingPolicy["sendConfirmationsToOwner"], "timeSlotInterval" = var.schedulingPolicy["timeSlotInterval"] } : key0 => value0 if value0 != null })
    "webSiteUrl"          = var.webSiteUrl
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "solutions/bookingBusinesses"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
