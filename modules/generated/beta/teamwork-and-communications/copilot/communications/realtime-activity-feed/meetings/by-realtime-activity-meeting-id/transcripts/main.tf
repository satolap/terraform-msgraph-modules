# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type" = var.odata_type
    "payloads"    = (var.payloads == null ? null : [for item0 in var.payloads : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "audioCaptureDateTime" = item0["audioCaptureDateTime"], "speaker" = item0["speaker"], "spokenLanguage" = item0["spokenLanguage"], "text" = item0["text"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "copilot/communications/realtimeActivityFeed/meetings/${urlencode(var.realtime_activity_meeting_id)}/transcripts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
