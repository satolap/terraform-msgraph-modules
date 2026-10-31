# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "end"              = (var.end == null ? null : { for key0, value0 in { "@odata.type" = var.end["odata_type"], "dateTime" = var.end["dateTime"], "timeZone" = var.end["timeZone"] } : key0 => value0 if value0 != null })
    "@odata.type"      = var.odata_type
    "placeId"          = var.placeId
    "recurrenceId"     = var.recurrenceId
    "start"            = (var.start == null ? null : { for key0, value0 in { "@odata.type" = var.start["odata_type"], "dateTime" = var.start["dateTime"], "timeZone" = var.start["timeZone"] } : key0 => value0 if value0 != null })
    "timeOffDetails"   = (var.timeOffDetails == null ? null : { for key0, value0 in { "@odata.type" = var.timeOffDetails["odata_type"], "isAllDay" = var.timeOffDetails["isAllDay"], "subject" = var.timeOffDetails["subject"] } : key0 => value0 if value0 != null })
    "workLocationType" = var.workLocationType
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user-id)}/settings/workHoursAndLocations/occurrences"
  api_version             = "beta"
  update_method           = "PUT"
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
