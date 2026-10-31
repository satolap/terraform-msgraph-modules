# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "ccRecipients"          = (var.ccRecipients == null ? null : [for item0 in var.ccRecipients : item0 if item0 != null])
    "hasAttachments"        = var.hasAttachments
    "isLocked"              = var.isLocked
    "lastDeliveredDateTime" = var.lastDeliveredDateTime
    "@odata.type"           = var.odata_type
    "posts"                 = (var.posts == null ? null : [for item0 in var.posts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "body" = (item0["body"] == null ? null : { for key2, value2 in { "@odata.type" = item0["body"]["odata_type"], "content" = item0["body"]["content"], "contentType" = item0["body"]["contentType"] } : key2 => value2 if value2 != null }), "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "from" = item0["from"], "hasAttachments" = item0["hasAttachments"], "importance" = item0["importance"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "mentions" = (item0["mentions"] == null ? null : [for item2 in item0["mentions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "application" = item2["application"], "clientReference" = item2["clientReference"], "createdBy" = item2["createdBy"], "createdDateTime" = item2["createdDateTime"], "deepLink" = item2["deepLink"], "mentionText" = item2["mentionText"], "mentioned" = item2["mentioned"], "serverCreatedDateTime" = item2["serverCreatedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "newParticipants" = (item0["newParticipants"] == null ? null : [for item2 in item0["newParticipants"] : item2 if item2 != null]), "receivedDateTime" = item0["receivedDateTime"], "sender" = item0["sender"] } : key1 => value1 if value1 != null }) if item0 != null])
    "preview"               = var.preview
    "toRecipients"          = (var.toRecipients == null ? null : [for item0 in var.toRecipients : item0 if item0 != null])
    "topic"                 = var.topic
    "uniqueSenders"         = (var.uniqueSenders == null ? null : [for item0 in var.uniqueSenders : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group-id)}/conversations/${urlencode(var.conversation-id)}/threads"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["posts"], name)])]))))] } : null

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
