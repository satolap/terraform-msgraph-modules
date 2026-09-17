# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "ccRecipients"          = (var.cc_recipients == null ? null : [for item0 in var.cc_recipients : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hasAttachments"        = var.has_attachments
    "isLocked"              = var.is_locked
    "lastDeliveredDateTime" = var.last_delivered_date_time
    "@odata.type"           = var.odata_type
    "posts"                 = (var.posts == null ? null : [for item0 in var.posts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "body" = item0["body"], "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "from" = (item0["from"] == null ? null : { for key2, value2 in { "@odata.type" = item0["from"]["odata_type"], "emailAddress" = item0["from"]["emailAddress"] } : key2 => value2 if value2 != null }), "hasAttachments" = item0["hasAttachments"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "newParticipants" = (item0["newParticipants"] == null ? null : [for item2 in item0["newParticipants"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "emailAddress" = item2["emailAddress"] } : key3 => value3 if value3 != null }) if item2 != null]), "receivedDateTime" = item0["receivedDateTime"], "sender" = item0["sender"] } : key1 => value1 if value1 != null }) if item0 != null])
    "preview"               = var.preview
    "toRecipients"          = (var.to_recipients == null ? null : [for item0 in var.to_recipients : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "topic"                 = var.topic
    "uniqueSenders"         = (var.unique_senders == null ? null : [for item0 in var.unique_senders : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/threads"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
