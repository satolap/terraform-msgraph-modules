# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contentType" = item0["contentType"], "isInline" = item0["isInline"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "name" = item0["name"], "size" = item0["size"] } : key1 => value1 if value1 != null }) if item0 != null])
    "bccRecipients"                 = (var.bcc_recipients == null ? null : [for item0 in var.bcc_recipients : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "body"                          = var.body
    "bodyPreview"                   = var.body_preview
    "categories"                    = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "ccRecipients"                  = (var.cc_recipients == null ? null : [for item0 in var.cc_recipients : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "conversationId"                = var.conversation_id
    "conversationIndex"             = var.conversation_index
    "createdDateTime"               = var.created_date_time
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "flag"                          = var.flag
    "from"                          = var.from
    "hasAttachments"                = var.has_attachments
    "importance"                    = var.importance
    "inferenceClassification"       = var.inference_classification
    "internetMessageId"             = var.internet_message_id
    "isDeliveryReceiptRequested"    = var.is_delivery_receipt_requested
    "isDraft"                       = var.is_draft
    "isRead"                        = var.is_read
    "isReadReceiptRequested"        = var.is_read_receipt_requested
    "lastModifiedDateTime"          = var.last_modified_date_time
    "multiValueExtendedProperties"  = (var.multi_value_extended_properties == null ? null : [for item0 in var.multi_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = (item0["value"] == null ? null : [for item2 in item0["value"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "parentFolderId"                = var.parent_folder_id
    "receivedDateTime"              = var.received_date_time
    "replyTo"                       = (var.reply_to == null ? null : [for item0 in var.reply_to : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sender"                        = var.sender
    "sentDateTime"                  = var.sent_date_time
    "singleValueExtendedProperties" = (var.single_value_extended_properties == null ? null : [for item0 in var.single_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "subject"                       = var.subject
    "toRecipients"                  = (var.to_recipients == null ? null : [for item0 in var.to_recipients : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "uniqueBody"                    = var.unique_body
    "webLink"                       = var.web_link
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/mailFolders/${urlencode(var.mail_folder_id)}/childFolders/${urlencode(var.mail_folder_id1)}/messages"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
