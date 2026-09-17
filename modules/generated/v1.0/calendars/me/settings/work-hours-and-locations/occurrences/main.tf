# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "end"              = (var.end == null ? null : { for key0, value0 in { "@odata.type" = var.end["odata_type"], "dateTime" = var.end["dateTime"], "timeZone" = var.end["timeZone"] } : key0 => value0 if value0 != null })
    "@odata.type"      = var.odata_type
    "placeId"          = var.place_id
    "recurrenceId"     = var.recurrence_id
    "start"            = (var.start == null ? null : { for key0, value0 in { "@odata.type" = var.start["odata_type"], "dateTime" = var.start["dateTime"], "timeZone" = var.start["timeZone"] } : key0 => value0 if value0 != null })
    "timeOffDetails"   = var.time_off_details
    "workLocationType" = var.work_location_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/settings/workHoursAndLocations/occurrences"
  api_version             = "v1.0"
  update_method           = "PUT"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
