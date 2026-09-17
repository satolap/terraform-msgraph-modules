# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"     = var.activity
    "duration"     = var.duration
    "endDate"      = var.end_date
    "@odata.type"  = var.odata_type
    "startDate"    = var.start_date
    "timeZoneUsed" = var.time_zone_used
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/analytics/activityStatistics"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
