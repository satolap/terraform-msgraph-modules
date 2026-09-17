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
    "schedulingPolicy"                 = var.scheduling_policy
    "smsNotificationsEnabled"          = var.sms_notifications_enabled
    "staffMemberIds"                   = (var.staff_member_ids == null ? null : [for item0 in var.staff_member_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/bookingBusinesses/${urlencode(var.booking_business_id)}/services"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
