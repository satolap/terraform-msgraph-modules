# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "interactionHistory" = var.interaction_history
    "@odata.type"        = var.odata_type
    "onlineMeetings"     = (var.online_meetings == null ? null : [for item0 in var.online_meetings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "aiInsights" = (item0["aiInsights"] == null ? null : [for item2 in item0["aiInsights"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "actionItems" = (item2["actionItems"] == null ? null : [for item4 in item2["actionItems"] : item4 if item4 != null]), "callId" = item2["callId"], "contentCorrelationId" = item2["contentCorrelationId"], "createdDateTime" = item2["createdDateTime"], "endDateTime" = item2["endDateTime"], "meetingNotes" = (item2["meetingNotes"] == null ? null : [for item4 in item2["meetingNotes"] : item4 if item4 != null]), "viewpoint" = item2["viewpoint"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "copilot/users"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
