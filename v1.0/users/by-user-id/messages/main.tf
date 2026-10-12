# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : item0 if item0 != null])
    "bccRecipients"                 = (var.bcc_recipients == null ? null : [for item0 in var.bcc_recipients : item0 if item0 != null])
    "body"                          = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"] } : key0 => value0 if value0 != null })
    "bodyPreview"                   = var.body_preview
    "categories"                    = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "ccRecipients"                  = (var.cc_recipients == null ? null : [for item0 in var.cc_recipients : item0 if item0 != null])
    "conversationId"                = var.conversation_id
    "conversationIndex"             = var.conversation_index
    "createdDateTime"               = var.created_date_time
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "flag"                          = (var.flag == null ? null : { for key0, value0 in { "@odata.type" = var.flag["odata_type"], "completedDateTime" = (var.flag["completedDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["completedDateTime"]["odata_type"], "dateTime" = var.flag["completedDateTime"]["dateTime"], "timeZone" = var.flag["completedDateTime"]["timeZone"] } : key1 => value1 if value1 != null }), "dueDateTime" = (var.flag["dueDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["dueDateTime"]["odata_type"], "dateTime" = var.flag["dueDateTime"]["dateTime"], "timeZone" = var.flag["dueDateTime"]["timeZone"] } : key1 => value1 if value1 != null }), "flagStatus" = var.flag["flagStatus"], "startDateTime" = (var.flag["startDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["startDateTime"]["odata_type"], "dateTime" = var.flag["startDateTime"]["dateTime"], "timeZone" = var.flag["startDateTime"]["timeZone"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
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
    "replyTo"                       = (var.reply_to == null ? null : [for item0 in var.reply_to : item0 if item0 != null])
    "sender"                        = var.sender
    "sentDateTime"                  = var.sent_date_time
    "singleValueExtendedProperties" = (var.single_value_extended_properties == null ? null : [for item0 in var.single_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "subject"                       = var.subject
    "toRecipients"                  = (var.to_recipients == null ? null : [for item0 in var.to_recipients : item0 if item0 != null])
    "uniqueBody"                    = (var.unique_body == null ? null : { for key0, value0 in { "@odata.type" = var.unique_body["odata_type"], "content" = var.unique_body["content"], "contentType" = var.unique_body["contentType"] } : key0 => value0 if value0 != null })
    "webLink"                       = var.web_link
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/messages"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
