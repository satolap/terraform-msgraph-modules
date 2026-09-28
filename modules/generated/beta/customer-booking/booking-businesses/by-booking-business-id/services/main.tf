# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"            = var.additional_information
    "createdDateTime"                  = var.created_date_time
    "customQuestions"                  = (var.custom_questions == null ? null : [for item0 in var.custom_questions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isRequired" = item0["isRequired"], "questionId" = item0["questionId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "defaultDuration"                  = var.default_duration
    "defaultLocation"                  = var.default_location
    "defaultPrice"                     = var.default_price
    "defaultPriceType"                 = var.default_price_type
    "defaultReminders"                 = (var.default_reminders == null ? null : [for item0 in var.default_reminders : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "message" = item0["message"], "offset" = item0["offset"], "recipients" = item0["recipients"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                      = var.description
    "displayName"                      = var.display_name
    "isAnonymousJoinEnabled"           = var.is_anonymous_join_enabled
    "isCustomerAllowedToManageBooking" = var.is_customer_allowed_to_manage_booking
    "isHiddenFromCustomers"            = var.is_hidden_from_customers
    "isLocationOnline"                 = var.is_location_online
    "languageTag"                      = var.language_tag
    "lastUpdatedDateTime"              = var.last_updated_date_time
    "maximumAttendeesCount"            = var.maximum_attendees_count
    "notes"                            = var.notes
    "@odata.type"                      = var.odata_type
    "postBuffer"                       = var.post_buffer
    "preBuffer"                        = var.pre_buffer
    "schedulingPolicy"                 = (var.scheduling_policy == null ? null : { for key0, value0 in { "@odata.type" = var.scheduling_policy["odata_type"], "allowStaffSelection" = var.scheduling_policy["allowStaffSelection"], "customAvailabilities" = (var.scheduling_policy["customAvailabilities"] == null ? null : [for item1 in var.scheduling_policy["customAvailabilities"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "availabilityType" = item1["availabilityType"], "businessHours" = (item1["businessHours"] == null ? null : [for item3 in item1["businessHours"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "day" = item3["day"], "timeSlots" = item3["timeSlots"] } : key4 => value4 if value4 != null }) if item3 != null]), "endDate" = item1["endDate"], "startDate" = item1["startDate"] } : key2 => value2 if value2 != null }) if item1 != null]), "generalAvailability" = var.scheduling_policy["generalAvailability"], "isMeetingInviteToCustomersEnabled" = var.scheduling_policy["isMeetingInviteToCustomersEnabled"], "maximumAdvance" = var.scheduling_policy["maximumAdvance"], "minimumLeadTime" = var.scheduling_policy["minimumLeadTime"], "sendConfirmationsToOwner" = var.scheduling_policy["sendConfirmationsToOwner"], "timeSlotInterval" = var.scheduling_policy["timeSlotInterval"] } : key0 => value0 if value0 != null })
    "smsNotificationsEnabled"          = var.sms_notifications_enabled
    "staffMemberIds"                   = (var.staff_member_ids == null ? null : [for item0 in var.staff_member_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "bookingBusinesses/${urlencode(var.booking_business_id)}/services"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
