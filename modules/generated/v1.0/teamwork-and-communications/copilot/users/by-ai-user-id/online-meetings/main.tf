# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "aiInsights"  = (var.ai_insights == null ? null : [for item0 in var.ai_insights : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actionItems" = (item0["actionItems"] == null ? null : [for item2 in item0["actionItems"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "ownerDisplayName" = item2["ownerDisplayName"], "text" = item2["text"], "title" = item2["title"] } : key3 => value3 if value3 != null }) if item2 != null]), "callId" = item0["callId"], "contentCorrelationId" = item0["contentCorrelationId"], "createdDateTime" = item0["createdDateTime"], "endDateTime" = item0["endDateTime"], "meetingNotes" = (item0["meetingNotes"] == null ? null : [for item2 in item0["meetingNotes"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "subpoints" = (item2["subpoints"] == null ? null : [for item4 in item2["subpoints"] : item4 if item4 != null]), "text" = item2["text"], "title" = item2["title"] } : key3 => value3 if value3 != null }) if item2 != null]), "viewpoint" = item0["viewpoint"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "copilot/users/${urlencode(var.ai_user_id)}/onlineMeetings"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
