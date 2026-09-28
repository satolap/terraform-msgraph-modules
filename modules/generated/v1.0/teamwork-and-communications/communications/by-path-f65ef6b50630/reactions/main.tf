# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/onlineMeetingConversations/${urlencode(var.online_meeting_engagement_conversation_id)}/messages/${urlencode(var.engagement_conversation_message_id)}/replies/${urlencode(var.engagement_conversation_message_id1)}/reactions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
