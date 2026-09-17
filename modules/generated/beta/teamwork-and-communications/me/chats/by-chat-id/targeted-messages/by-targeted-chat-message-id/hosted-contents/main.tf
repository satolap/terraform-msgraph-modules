# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "contentBytes" = var.content_bytes
    "contentType"  = var.content_type
    "@odata.type"  = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/chats/${urlencode(var.chat_id)}/targetedMessages/${urlencode(var.targeted_chat_message_id)}/hostedContents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
