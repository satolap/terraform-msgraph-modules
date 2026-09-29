# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activities"  = (var.activities == null ? null : { for key0, value0 in { "@odata.type" = var.activities["odata_type"], "transcript" = (var.activities["transcript"] == null ? null : { for key1, value1 in { "@odata.type" = var.activities["transcript"]["odata_type"], "resultInfo" = (var.activities["transcript"]["resultInfo"] == null ? null : { for key2, value2 in { "@odata.type" = var.activities["transcript"]["resultInfo"]["odata_type"], "code" = var.activities["transcript"]["resultInfo"]["code"], "message" = var.activities["transcript"]["resultInfo"]["message"], "subcode" = var.activities["transcript"]["resultInfo"]["subcode"] } : key2 => value2 if value2 != null }), "status" = var.activities["transcript"]["status"], "transport" = (var.activities["transcript"]["transport"] == null ? null : { for key2, value2 in { "@odata.type" = var.activities["transcript"]["transport"]["odata_type"], "connectionType" = var.activities["transcript"]["transport"]["connectionType"], "url" = var.activities["transcript"]["transport"]["url"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "callbackUrl" = var.callback_url
    "chatInfo"    = (var.chat_info == null ? null : { for key0, value0 in { "@odata.type" = var.chat_info["odata_type"], "messageId" = var.chat_info["messageId"], "replyChainMessageId" = var.chat_info["replyChainMessageId"], "threadId" = var.chat_info["threadId"] } : key0 => value0 if value0 != null })
    "meetingInfo" = var.meeting_info
    "@odata.type" = var.odata_type
    "userId"      = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "copilot/communications/realtimeActivityFeed/multiActivitySubscriptions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
