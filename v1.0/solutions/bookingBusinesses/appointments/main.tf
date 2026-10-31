# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"            = var.additionalInformation
    "anonymousJoinWebUrl"              = var.anonymousJoinWebUrl
    "appointmentLabel"                 = var.appointmentLabel
    "createdDateTime"                  = var.createdDateTime
    "customerEmailAddress"             = var.customerEmailAddress
    "customerName"                     = var.customerName
    "customerNotes"                    = var.customerNotes
    "customerPhone"                    = var.customerPhone
    "customerTimeZone"                 = var.customerTimeZone
    "customers"                        = (var.customers == null ? null : [for item0 in var.customers : item0 if item0 != null])
    "endDateTime"                      = (var.endDateTime == null ? null : { for key0, value0 in { "@odata.type" = var.endDateTime["odata_type"], "dateTime" = var.endDateTime["dateTime"], "timeZone" = var.endDateTime["timeZone"] } : key0 => value0 if value0 != null })
    "isCustomerAllowedToManageBooking" = var.isCustomerAllowedToManageBooking
    "isLocationOnline"                 = var.isLocationOnline
    "joinWebUrl"                       = var.joinWebUrl
    "lastUpdatedDateTime"              = var.lastUpdatedDateTime
    "maximumAttendeesCount"            = var.maximumAttendeesCount
    "@odata.type"                      = var.odata_type
    "optOutOfCustomerEmail"            = var.optOutOfCustomerEmail
    "postBuffer"                       = var.postBuffer
    "preBuffer"                        = var.preBuffer
    "price"                            = var.price
    "priceType"                        = var.priceType
    "reminders"                        = (var.reminders == null ? null : [for item0 in var.reminders : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "message" = item0["message"], "offset" = item0["offset"], "recipients" = item0["recipients"] } : key1 => value1 if value1 != null }) if item0 != null])
    "selfServiceAppointmentId"         = var.selfServiceAppointmentId
    "serviceId"                        = var.serviceId
    "serviceLocation"                  = var.serviceLocation
    "serviceName"                      = var.serviceName
    "serviceNotes"                     = var.serviceNotes
    "smsNotificationsEnabled"          = var.smsNotificationsEnabled
    "staffMemberIds"                   = (var.staffMemberIds == null ? null : [for item0 in var.staffMemberIds : item0 if item0 != null])
    "startDateTime"                    = (var.startDateTime == null ? null : { for key0, value0 in { "@odata.type" = var.startDateTime["odata_type"], "dateTime" = var.startDateTime["dateTime"], "timeZone" = var.startDateTime["timeZone"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "solutions/bookingBusinesses/${urlencode(var.bookingBusiness-id)}/appointments"
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
