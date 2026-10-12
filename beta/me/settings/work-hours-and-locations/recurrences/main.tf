# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "end"              = (var.end == null ? null : { for key0, value0 in { "@odata.type" = var.end["odata_type"], "dateTime" = var.end["dateTime"], "timeZone" = var.end["timeZone"] } : key0 => value0 if value0 != null })
    "@odata.type"      = var.odata_type
    "placeId"          = var.place_id
    "recurrence"       = (var.recurrence == null ? null : { for key0, value0 in { "@odata.type" = var.recurrence["odata_type"], "pattern" = (var.recurrence["pattern"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["pattern"]["odata_type"], "dayOfMonth" = var.recurrence["pattern"]["dayOfMonth"], "daysOfWeek" = (var.recurrence["pattern"]["daysOfWeek"] == null ? null : [for item2 in var.recurrence["pattern"]["daysOfWeek"] : item2 if item2 != null]), "firstDayOfWeek" = var.recurrence["pattern"]["firstDayOfWeek"], "index" = var.recurrence["pattern"]["index"], "interval" = var.recurrence["pattern"]["interval"], "month" = var.recurrence["pattern"]["month"], "type" = var.recurrence["pattern"]["type"] } : key1 => value1 if value1 != null }), "range" = (var.recurrence["range"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["range"]["odata_type"], "endDate" = var.recurrence["range"]["endDate"], "numberOfOccurrences" = var.recurrence["range"]["numberOfOccurrences"], "recurrenceTimeZone" = var.recurrence["range"]["recurrenceTimeZone"], "startDate" = var.recurrence["range"]["startDate"], "type" = var.recurrence["range"]["type"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "start"            = (var.start == null ? null : { for key0, value0 in { "@odata.type" = var.start["odata_type"], "dateTime" = var.start["dateTime"], "timeZone" = var.start["timeZone"] } : key0 => value0 if value0 != null })
    "workLocationType" = var.work_location_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/settings/workHoursAndLocations/recurrences"
  api_version             = "beta"
  update_method           = "PUT"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
