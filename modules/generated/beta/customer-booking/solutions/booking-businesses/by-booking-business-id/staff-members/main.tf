# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "availabilityIsAffectedByPersonalCalendar" = var.availability_is_affected_by_personal_calendar
    "colorIndex"                               = var.color_index
    "createdDateTime"                          = var.created_date_time
    "displayName"                              = var.display_name
    "emailAddress"                             = var.email_address
    "isEmailNotificationEnabled"               = var.is_email_notification_enabled
    "lastUpdatedDateTime"                      = var.last_updated_date_time
    "membershipStatus"                         = var.membership_status
    "@odata.type"                              = var.odata_type
    "role"                                     = var.role
    "timeZone"                                 = var.time_zone
    "useBusinessHours"                         = var.use_business_hours
    "workingHours"                             = (var.working_hours == null ? null : [for item0 in var.working_hours : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "day" = item0["day"], "timeSlots" = (item0["timeSlots"] == null ? null : [for item2 in item0["timeSlots"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "end" = item2["end"], "start" = item2["start"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/bookingBusinesses/${urlencode(var.booking_business_id)}/staffMembers"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
