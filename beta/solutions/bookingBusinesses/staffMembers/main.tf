# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "availabilityIsAffectedByPersonalCalendar" = var.availabilityIsAffectedByPersonalCalendar
    "colorIndex"                               = var.colorIndex
    "createdDateTime"                          = var.createdDateTime
    "displayName"                              = var.displayName
    "emailAddress"                             = var.emailAddress
    "isEmailNotificationEnabled"               = var.isEmailNotificationEnabled
    "lastUpdatedDateTime"                      = var.lastUpdatedDateTime
    "membershipStatus"                         = var.membershipStatus
    "@odata.type"                              = var.odata_type
    "role"                                     = var.role
    "timeZone"                                 = var.timeZone
    "useBusinessHours"                         = var.useBusinessHours
    "workingHours"                             = (var.workingHours == null ? null : [for item0 in var.workingHours : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "day" = item0["day"], "timeSlots" = (item0["timeSlots"] == null ? null : [for item2 in item0["timeSlots"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "end" = item2["end"], "start" = item2["start"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "solutions/bookingBusinesses/${urlencode(var.bookingBusiness-id)}/staffMembers"
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
