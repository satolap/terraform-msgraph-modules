# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"            = var.additional_information
    "anonymousJoinWebUrl"              = var.anonymous_join_web_url
    "appointmentLabel"                 = var.appointment_label
    "createdDateTime"                  = var.created_date_time
    "customerEmailAddress"             = var.customer_email_address
    "customerId"                       = var.customer_id
    "customerLocation"                 = var.customer_location
    "customerName"                     = var.customer_name
    "customerNotes"                    = var.customer_notes
    "customerPhone"                    = var.customer_phone
    "customerTimeZone"                 = var.customer_time_zone
    "customers"                        = (var.customers == null ? null : [for item0 in var.customers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "end"                              = (var.end == null ? null : { for key0, value0 in { "@odata.type" = var.end["odata_type"], "dateTime" = var.end["dateTime"], "timeZone" = var.end["timeZone"] } : key0 => value0 if value0 != null })
    "invoiceAmount"                    = var.invoice_amount
    "invoiceDate"                      = var.invoice_date
    "invoiceId"                        = var.invoice_id
    "invoiceStatus"                    = var.invoice_status
    "invoiceUrl"                       = var.invoice_url
    "isCustomerAllowedToManageBooking" = var.is_customer_allowed_to_manage_booking
    "isLocationOnline"                 = var.is_location_online
    "joinWebUrl"                       = var.join_web_url
    "lastUpdatedDateTime"              = var.last_updated_date_time
    "maximumAttendeesCount"            = var.maximum_attendees_count
    "@odata.type"                      = var.odata_type
    "onlineMeetingUrl"                 = var.online_meeting_url
    "optOutOfCustomerEmail"            = var.opt_out_of_customer_email
    "postBuffer"                       = var.post_buffer
    "preBuffer"                        = var.pre_buffer
    "price"                            = var.price
    "priceType"                        = var.price_type
    "reminders"                        = (var.reminders == null ? null : [for item0 in var.reminders : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "message" = item0["message"], "offset" = item0["offset"], "recipients" = item0["recipients"] } : key1 => value1 if value1 != null }) if item0 != null])
    "selfServiceAppointmentId"         = var.self_service_appointment_id
    "serviceId"                        = var.service_id
    "serviceLocation"                  = var.service_location
    "serviceName"                      = var.service_name
    "serviceNotes"                     = var.service_notes
    "smsNotificationsEnabled"          = var.sms_notifications_enabled
    "staffMemberIds"                   = (var.staff_member_ids == null ? null : [for item0 in var.staff_member_ids : item0 if item0 != null])
    "start"                            = (var.start == null ? null : { for key0, value0 in { "@odata.type" = var.start["odata_type"], "dateTime" = var.start["dateTime"], "timeZone" = var.start["timeZone"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "bookingBusinesses/${urlencode(var.booking_business_id)}/appointments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
