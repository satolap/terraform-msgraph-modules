# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"      = (var.action == null ? null : { for key0, value0 in { "@odata.type" = var.action["odata_type"], "comment" = (var.action["comment"] == null ? null : { for key1, value1 in { "@odata.type" = var.action["comment"]["odata_type"], "isReply" = var.action["comment"]["isReply"], "parentAuthor" = var.action["comment"]["parentAuthor"], "participants" = (var.action["comment"]["participants"] == null ? null : [for item2 in var.action["comment"]["participants"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }), "create" = var.action["create"], "delete" = (var.action["delete"] == null ? null : { for key1, value1 in { "@odata.type" = var.action["delete"]["odata_type"], "name" = var.action["delete"]["name"], "objectType" = var.action["delete"]["objectType"] } : key1 => value1 if value1 != null }), "edit" = var.action["edit"], "mention" = (var.action["mention"] == null ? null : { for key1, value1 in { "@odata.type" = var.action["mention"]["odata_type"], "mentionees" = (var.action["mention"]["mentionees"] == null ? null : [for item2 in var.action["mention"]["mentionees"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }), "move" = (var.action["move"] == null ? null : { for key1, value1 in { "@odata.type" = var.action["move"]["odata_type"], "from" = var.action["move"]["from"], "to" = var.action["move"]["to"] } : key1 => value1 if value1 != null }), "rename" = (var.action["rename"] == null ? null : { for key1, value1 in { "@odata.type" = var.action["rename"]["odata_type"], "newName" = var.action["rename"]["newName"], "oldName" = var.action["rename"]["oldName"] } : key1 => value1 if value1 != null }), "restore" = var.action["restore"], "share" = (var.action["share"] == null ? null : { for key1, value1 in { "@odata.type" = var.action["share"]["odata_type"], "recipients" = (var.action["share"]["recipients"] == null ? null : [for item2 in var.action["share"]["recipients"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }), "version" = (var.action["version"] == null ? null : { for key1, value1 in { "@odata.type" = var.action["version"]["odata_type"], "newVersion" = var.action["version"]["newVersion"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "actor"       = var.actor
    "driveItem"   = var.drive_item
    "listItem"    = var.list_item
    "@odata.type" = var.odata_type
    "times"       = (var.times == null ? null : { for key0, value0 in { "@odata.type" = var.times["odata_type"], "lastRecordedDateTime" = var.times["lastRecordedDateTime"], "observedDateTime" = var.times["observedDateTime"], "recordedDateTime" = var.times["recordedDateTime"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/activities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
