# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachments"     = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "contentType" = item0["contentType"], "contentUrl" = item0["contentUrl"], "name" = item0["name"], "teamsAppId" = item0["teamsAppId"], "thumbnailUrl" = item0["thumbnailUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "body"            = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"], "messageBodyContentType" = var.body["messageBodyContentType"] } : key0 => value0 if value0 != null })
    "channelIdentity" = (var.channel_identity == null ? null : { for key0, value0 in { "@odata.type" = var.channel_identity["odata_type"], "channelId" = var.channel_identity["channelId"], "teamId" = var.channel_identity["teamId"] } : key0 => value0 if value0 != null })
    "chatId"          = var.chat_id
    "createdDateTime" = var.created_date_time
    "from"            = (var.from == null ? null : { for key0, value0 in { "@odata.type" = var.from["odata_type"], "application" = var.from["application"], "device" = var.from["device"], "user" = var.from["user"] } : key0 => value0 if value0 != null })
    "hasReplies"      = var.has_replies
    "hostedContents"  = (var.hosted_contents == null ? null : [for item0 in var.hosted_contents : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contentBytes" = item0["contentBytes"], "contentType" = item0["contentType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "importance"      = var.importance
    "locale"          = var.locale
    "mentions"        = (var.mentions == null ? null : [for item0 in var.mentions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "id" = item0["id"], "mentionText" = item0["mentionText"], "mentioned" = (item0["mentioned"] == null ? null : { for key2, value2 in { "@odata.type" = item0["mentioned"]["odata_type"], "application" = item0["mentioned"]["application"], "conversation" = (item0["mentioned"]["conversation"] == null ? null : { for key3, value3 in { "@odata.type" = item0["mentioned"]["conversation"]["odata_type"], "conversationIdentityType" = item0["mentioned"]["conversation"]["conversationIdentityType"], "displayName" = item0["mentioned"]["conversation"]["displayName"], "id" = item0["mentioned"]["conversation"]["id"] } : key3 => value3 if value3 != null }), "device" = item0["mentioned"]["device"], "tag" = (item0["mentioned"]["tag"] == null ? null : { for key3, value3 in { "@odata.type" = item0["mentioned"]["tag"]["odata_type"], "displayName" = item0["mentioned"]["tag"]["displayName"], "id" = item0["mentioned"]["tag"]["id"] } : key3 => value3 if value3 != null }), "user" = item0["mentioned"]["user"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "messageHistory"  = (var.message_history == null ? null : [for item0 in var.message_history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actions" = item0["actions"], "modifiedDateTime" = item0["modifiedDateTime"], "reaction" = (item0["reaction"] == null ? null : { for key2, value2 in { "@odata.type" = item0["reaction"]["odata_type"], "createdDateTime" = item0["reaction"]["createdDateTime"], "displayName" = item0["reaction"]["displayName"], "reactionContentUrl" = item0["reaction"]["reactionContentUrl"], "reactionType" = item0["reaction"]["reactionType"], "user" = (item0["reaction"]["user"] == null ? null : { for key3, value3 in { "@odata.type" = item0["reaction"]["user"]["odata_type"], "application" = item0["reaction"]["user"]["application"], "device" = item0["reaction"]["user"]["device"], "user" = item0["reaction"]["user"]["user"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "messageType"     = var.message_type
    "@odata.type"     = var.odata_type
    "onBehalfOf"      = (var.on_behalf_of == null ? null : { for key0, value0 in { "@odata.type" = var.on_behalf_of["odata_type"], "application" = var.on_behalf_of["application"], "device" = var.on_behalf_of["device"], "user" = var.on_behalf_of["user"] } : key0 => value0 if value0 != null })
    "policyViolation" = (var.policy_violation == null ? null : { for key0, value0 in { "@odata.type" = var.policy_violation["odata_type"], "dlpAction" = var.policy_violation["dlpAction"], "justificationText" = var.policy_violation["justificationText"], "policyTip" = (var.policy_violation["policyTip"] == null ? null : { for key1, value1 in { "@odata.type" = var.policy_violation["policyTip"]["odata_type"], "complianceUrl" = var.policy_violation["policyTip"]["complianceUrl"], "generalText" = var.policy_violation["policyTip"]["generalText"], "matchedConditionDescriptions" = (var.policy_violation["policyTip"]["matchedConditionDescriptions"] == null ? null : [for item2 in var.policy_violation["policyTip"]["matchedConditionDescriptions"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }), "userAction" = var.policy_violation["userAction"], "verdictDetails" = var.policy_violation["verdictDetails"] } : key0 => value0 if value0 != null })
    "reactions"       = (var.reactions == null ? null : [for item0 in var.reactions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "reactionContentUrl" = item0["reactionContentUrl"], "reactionType" = item0["reactionType"], "user" = (item0["user"] == null ? null : { for key2, value2 in { "@odata.type" = item0["user"]["odata_type"], "application" = item0["user"]["application"], "device" = item0["user"]["device"], "user" = item0["user"]["user"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "replies"         = (var.replies == null ? null : [for item0 in var.replies : item0 if item0 != null])
    "subject"         = var.subject
    "summary"         = var.summary
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/team/primaryChannel/messages/${urlencode(var.chat_message_id)}/replies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
