# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"            = var.additionalInformation
    "createdDateTime"                  = var.createdDateTime
    "customQuestions"                  = (var.customQuestions == null ? null : [for item0 in var.customQuestions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isRequired" = item0["isRequired"], "questionId" = item0["questionId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "defaultDuration"                  = var.defaultDuration
    "defaultLocation"                  = var.defaultLocation
    "defaultPrice"                     = var.defaultPrice
    "defaultPriceType"                 = var.defaultPriceType
    "defaultReminders"                 = (var.defaultReminders == null ? null : [for item0 in var.defaultReminders : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "message" = item0["message"], "offset" = item0["offset"], "recipients" = item0["recipients"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                      = var.description
    "displayName"                      = var.displayName
    "isAnonymousJoinEnabled"           = var.isAnonymousJoinEnabled
    "isCustomerAllowedToManageBooking" = var.isCustomerAllowedToManageBooking
    "isHiddenFromCustomers"            = var.isHiddenFromCustomers
    "isLocationOnline"                 = var.isLocationOnline
    "languageTag"                      = var.languageTag
    "lastUpdatedDateTime"              = var.lastUpdatedDateTime
    "maximumAttendeesCount"            = var.maximumAttendeesCount
    "notes"                            = var.notes
    "@odata.type"                      = var.odata_type
    "postBuffer"                       = var.postBuffer
    "preBuffer"                        = var.preBuffer
    "schedulingPolicy"                 = (var.schedulingPolicy == null ? null : { for key0, value0 in { "@odata.type" = var.schedulingPolicy["odata_type"], "allowStaffSelection" = var.schedulingPolicy["allowStaffSelection"], "customAvailabilities" = (var.schedulingPolicy["customAvailabilities"] == null ? null : [for item1 in var.schedulingPolicy["customAvailabilities"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "availabilityType" = item1["availabilityType"], "businessHours" = (item1["businessHours"] == null ? null : [for item3 in item1["businessHours"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "day" = item3["day"], "timeSlots" = item3["timeSlots"] } : key4 => value4 if value4 != null }) if item3 != null]), "endDate" = item1["endDate"], "startDate" = item1["startDate"] } : key2 => value2 if value2 != null }) if item1 != null]), "generalAvailability" = var.schedulingPolicy["generalAvailability"], "isMeetingInviteToCustomersEnabled" = var.schedulingPolicy["isMeetingInviteToCustomersEnabled"], "maximumAdvance" = var.schedulingPolicy["maximumAdvance"], "minimumLeadTime" = var.schedulingPolicy["minimumLeadTime"], "sendConfirmationsToOwner" = var.schedulingPolicy["sendConfirmationsToOwner"], "timeSlotInterval" = var.schedulingPolicy["timeSlotInterval"] } : key0 => value0 if value0 != null })
    "smsNotificationsEnabled"          = var.smsNotificationsEnabled
    "staffMemberIds"                   = (var.staffMemberIds == null ? null : [for item0 in var.staffMemberIds : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "solutions/bookingBusinesses/${urlencode(var.bookingBusiness-id)}/services"
  api_version             = "beta"
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
