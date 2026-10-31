# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : item0 if item0 != null])
    "bccRecipients"                 = (var.bccRecipients == null ? null : [for item0 in var.bccRecipients : item0 if item0 != null])
    "body"                          = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"] } : key0 => value0 if value0 != null })
    "bodyPreview"                   = var.bodyPreview
    "categories"                    = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "ccRecipients"                  = (var.ccRecipients == null ? null : [for item0 in var.ccRecipients : item0 if item0 != null])
    "conversationId"                = var.conversationId
    "conversationIndex"             = var.conversationIndex
    "createdDateTime"               = var.createdDateTime
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "flag"                          = (var.flag == null ? null : { for key0, value0 in { "@odata.type" = var.flag["odata_type"], "completedDateTime" = (var.flag["completedDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["completedDateTime"]["odata_type"], "dateTime" = var.flag["completedDateTime"]["dateTime"], "timeZone" = var.flag["completedDateTime"]["timeZone"] } : key1 => value1 if value1 != null }), "dueDateTime" = (var.flag["dueDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["dueDateTime"]["odata_type"], "dateTime" = var.flag["dueDateTime"]["dateTime"], "timeZone" = var.flag["dueDateTime"]["timeZone"] } : key1 => value1 if value1 != null }), "flagStatus" = var.flag["flagStatus"], "startDateTime" = (var.flag["startDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["startDateTime"]["odata_type"], "dateTime" = var.flag["startDateTime"]["dateTime"], "timeZone" = var.flag["startDateTime"]["timeZone"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "from"                          = var.from
    "hasAttachments"                = var.hasAttachments
    "importance"                    = var.importance
    "inferenceClassification"       = var.inferenceClassification
    "internetMessageId"             = var.internetMessageId
    "isDeliveryReceiptRequested"    = var.isDeliveryReceiptRequested
    "isDraft"                       = var.isDraft
    "isRead"                        = var.isRead
    "isReadReceiptRequested"        = var.isReadReceiptRequested
    "lastModifiedDateTime"          = var.lastModifiedDateTime
    "multiValueExtendedProperties"  = (var.multiValueExtendedProperties == null ? null : [for item0 in var.multiValueExtendedProperties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = (item0["value"] == null ? null : [for item2 in item0["value"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "parentFolderId"                = var.parentFolderId
    "receivedDateTime"              = var.receivedDateTime
    "replyTo"                       = (var.replyTo == null ? null : [for item0 in var.replyTo : item0 if item0 != null])
    "sender"                        = var.sender
    "sentDateTime"                  = var.sentDateTime
    "singleValueExtendedProperties" = (var.singleValueExtendedProperties == null ? null : [for item0 in var.singleValueExtendedProperties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "subject"                       = var.subject
    "toRecipients"                  = (var.toRecipients == null ? null : [for item0 in var.toRecipients : item0 if item0 != null])
    "uniqueBody"                    = (var.uniqueBody == null ? null : { for key0, value0 in { "@odata.type" = var.uniqueBody["odata_type"], "content" = var.uniqueBody["content"], "contentType" = var.uniqueBody["contentType"] } : key0 => value0 if value0 != null })
    "webLink"                       = var.webLink
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user-id)}/mailFolders/${urlencode(var.mailFolder-id)}/messages"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["attachments", "extensions", "multiValueExtendedProperties", "singleValueExtendedProperties"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
