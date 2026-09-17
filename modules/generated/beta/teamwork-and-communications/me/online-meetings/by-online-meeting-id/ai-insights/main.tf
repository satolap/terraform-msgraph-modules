# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionItems"          = (var.action_items == null ? null : [for item0 in var.action_items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ownerDisplayName" = item0["ownerDisplayName"], "text" = item0["text"], "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "callId"               = var.call_id
    "contentCorrelationId" = var.content_correlation_id
    "createdDateTime"      = var.created_date_time
    "endDateTime"          = var.end_date_time
    "meetingNotes"         = (var.meeting_notes == null ? null : [for item0 in var.meeting_notes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "subpoints" = (item0["subpoints"] == null ? null : [for item2 in item0["subpoints"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "text" = item2["text"], "title" = item2["title"] } : key3 => value3 if value3 != null }) if item2 != null]), "text" = item0["text"], "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"          = var.odata_type
    "viewpoint"            = var.viewpoint
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/onlineMeetings/${urlencode(var.online_meeting_id)}/aiInsights"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
