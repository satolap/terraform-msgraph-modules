# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type" = var.odata_type
    "transcripts" = (var.transcripts == null ? null : [for item0 in var.transcripts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "payloads" = (item0["payloads"] == null ? null : [for item2 in item0["payloads"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "audioCaptureDateTime" = item2["audioCaptureDateTime"], "speaker" = item2["speaker"], "spokenLanguage" = item2["spokenLanguage"], "text" = item2["text"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "copilot/communications/realtimeActivityFeed/meetings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
