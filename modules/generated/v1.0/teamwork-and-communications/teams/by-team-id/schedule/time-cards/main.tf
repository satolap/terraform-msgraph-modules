# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "breaks"        = (var.breaks == null ? null : [for item0 in var.breaks : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "breakId" = item0["breakId"], "end" = item0["end"], "notes" = item0["notes"], "start" = (item0["start"] == null ? null : { for key2, value2 in { "@odata.type" = item0["start"]["odata_type"], "dateTime" = item0["start"]["dateTime"], "isAtApprovedLocation" = item0["start"]["isAtApprovedLocation"], "notes" = item0["start"]["notes"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "clockInEvent"  = var.clock_in_event
    "clockOutEvent" = var.clock_out_event
    "confirmedBy"   = var.confirmed_by
    "createdBy"     = var.created_by
    "notes"         = var.notes
    "@odata.type"   = var.odata_type
    "originalEntry" = var.original_entry
    "state"         = var.state
    "userId"        = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teams/${urlencode(var.team_id)}/schedule/timeCards"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
