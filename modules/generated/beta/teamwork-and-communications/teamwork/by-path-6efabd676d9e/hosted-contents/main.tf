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
  url                     = "teamwork/deletedTeams/${urlencode(var.deleted_team_id)}/channels/${urlencode(var.channel_id)}/messages/${urlencode(var.chat_message_id)}/replies/${urlencode(var.chat_message_id1)}/hostedContents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
