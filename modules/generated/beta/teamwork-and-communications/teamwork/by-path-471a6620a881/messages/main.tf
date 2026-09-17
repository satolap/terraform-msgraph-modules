# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachments"     = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "contentType" = item0["contentType"], "contentUrl" = item0["contentUrl"], "name" = item0["name"], "teamsAppId" = item0["teamsAppId"], "thumbnailUrl" = item0["thumbnailUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "body"            = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"], "messageBodyContentType" = var.body["messageBodyContentType"] } : key0 => value0 if value0 != null })
    "channelIdentity" = var.channel_identity
    "chatId"          = var.chat_id
    "createdDateTime" = var.created_date_time
    "from"            = var.from
    "hasReplies"      = var.has_replies
    "hostedContents"  = (var.hosted_contents == null ? null : [for item0 in var.hosted_contents : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contentBytes" = item0["contentBytes"], "contentType" = item0["contentType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "importance"      = var.importance
    "locale"          = var.locale
    "mentions"        = (var.mentions == null ? null : [for item0 in var.mentions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "id" = item0["id"], "mentionText" = item0["mentionText"], "mentioned" = item0["mentioned"] } : key1 => value1 if value1 != null }) if item0 != null])
    "messageHistory"  = (var.message_history == null ? null : [for item0 in var.message_history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actions" = item0["actions"], "modifiedDateTime" = item0["modifiedDateTime"], "reaction" = item0["reaction"] } : key1 => value1 if value1 != null }) if item0 != null])
    "messageType"     = var.message_type
    "@odata.type"     = var.odata_type
    "onBehalfOf"      = var.on_behalf_of
    "policyViolation" = var.policy_violation
    "reactions"       = (var.reactions == null ? null : [for item0 in var.reactions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "reactionContentUrl" = item0["reactionContentUrl"], "reactionType" = item0["reactionType"], "user" = (item0["user"] == null ? null : { for key2, value2 in { "@odata.type" = item0["user"]["odata_type"], "application" = item0["user"]["application"], "device" = item0["user"]["device"], "user" = item0["user"]["user"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "replies"         = (var.replies == null ? null : [for item0 in var.replies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "attachments" = (item0["attachments"] == null ? null : [for item2 in item0["attachments"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "content" = item2["content"], "contentType" = item2["contentType"], "contentUrl" = item2["contentUrl"], "name" = item2["name"], "teamsAppId" = item2["teamsAppId"], "thumbnailUrl" = item2["thumbnailUrl"] } : key3 => value3 if value3 != null }) if item2 != null]), "body" = (item0["body"] == null ? null : { for key2, value2 in { "@odata.type" = item0["body"]["odata_type"], "content" = item0["body"]["content"], "contentType" = item0["body"]["contentType"], "messageBodyContentType" = item0["body"]["messageBodyContentType"] } : key2 => value2 if value2 != null }), "channelIdentity" = item0["channelIdentity"], "chatId" = item0["chatId"], "createdDateTime" = item0["createdDateTime"], "from" = item0["from"], "hasReplies" = item0["hasReplies"], "hostedContents" = (item0["hostedContents"] == null ? null : [for item2 in item0["hostedContents"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "contentBytes" = item2["contentBytes"], "contentType" = item2["contentType"] } : key3 => value3 if value3 != null }) if item2 != null]), "importance" = item0["importance"], "locale" = item0["locale"], "mentions" = (item0["mentions"] == null ? null : [for item2 in item0["mentions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "id" = item2["id"], "mentionText" = item2["mentionText"], "mentioned" = item2["mentioned"] } : key3 => value3 if value3 != null }) if item2 != null]), "messageHistory" = (item0["messageHistory"] == null ? null : [for item2 in item0["messageHistory"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "actions" = item2["actions"], "modifiedDateTime" = item2["modifiedDateTime"], "reaction" = item2["reaction"] } : key3 => value3 if value3 != null }) if item2 != null]), "messageType" = item0["messageType"], "onBehalfOf" = item0["onBehalfOf"], "policyViolation" = item0["policyViolation"], "reactions" = (item0["reactions"] == null ? null : [for item2 in item0["reactions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdDateTime" = item2["createdDateTime"], "displayName" = item2["displayName"], "reactionContentUrl" = item2["reactionContentUrl"], "reactionType" = item2["reactionType"], "user" = (item2["user"] == null ? null : { for key4, value4 in { "@odata.type" = item2["user"]["odata_type"], "application" = item2["user"]["application"], "device" = item2["user"]["device"], "user" = item2["user"]["user"] } : key4 => value4 if value4 != null }) } : key3 => value3 if value3 != null }) if item2 != null]), "replies" = (item0["replies"] == null ? null : [for item2 in item0["replies"] : item2 if item2 != null]), "subject" = item0["subject"], "summary" = item0["summary"] } : key1 => value1 if value1 != null }) if item0 != null])
    "subject"         = var.subject
    "summary"         = var.summary
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/teamTemplates/${urlencode(var.team_template_id)}/definitions/${urlencode(var.team_template_definition_id)}/teamDefinition/primaryChannel/messages"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
