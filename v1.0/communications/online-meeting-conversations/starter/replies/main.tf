# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "body"         = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"] } : key0 => value0 if value0 != null })
    "conversation" = var.conversation
    "creationMode" = var.creation_mode
    "from"         = (var.from == null ? null : { for key0, value0 in { "@odata.type" = var.from["odata_type"], "application" = var.from["application"], "audience" = var.from["audience"], "device" = var.from["device"], "group" = var.from["group"], "user" = var.from["user"] } : key0 => value0 if value0 != null })
    "@odata.type"  = var.odata_type
    "reactions"    = (var.reactions == null ? null : [for item0 in var.reactions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "replies"      = (var.replies == null ? null : [for item0 in var.replies : item0 if item0 != null])
    "replyTo"      = var.reply_to
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/onlineMeetingConversations/${urlencode(var.online_meeting_engagement_conversation_id)}/starter/replies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
