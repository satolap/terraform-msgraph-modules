# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activities"          = (var.activities == null ? null : [for item0 in var.activities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = (item0["action"] == null ? null : { for key2, value2 in { "@odata.type" = item0["action"]["odata_type"], "comment" = (item0["action"]["comment"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["comment"]["odata_type"], "isReply" = item0["action"]["comment"]["isReply"], "parentAuthor" = item0["action"]["comment"]["parentAuthor"], "participants" = (item0["action"]["comment"]["participants"] == null ? null : [for item4 in item0["action"]["comment"]["participants"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "create" = item0["action"]["create"], "delete" = (item0["action"]["delete"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["delete"]["odata_type"], "name" = item0["action"]["delete"]["name"], "objectType" = item0["action"]["delete"]["objectType"] } : key3 => value3 if value3 != null }), "edit" = item0["action"]["edit"], "mention" = (item0["action"]["mention"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["mention"]["odata_type"], "mentionees" = (item0["action"]["mention"]["mentionees"] == null ? null : [for item4 in item0["action"]["mention"]["mentionees"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "move" = (item0["action"]["move"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["move"]["odata_type"], "from" = item0["action"]["move"]["from"], "to" = item0["action"]["move"]["to"] } : key3 => value3 if value3 != null }), "rename" = (item0["action"]["rename"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["rename"]["odata_type"], "newName" = item0["action"]["rename"]["newName"], "oldName" = item0["action"]["rename"]["oldName"] } : key3 => value3 if value3 != null }), "restore" = item0["action"]["restore"], "share" = (item0["action"]["share"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["share"]["odata_type"], "recipients" = (item0["action"]["share"]["recipients"] == null ? null : [for item4 in item0["action"]["share"]["recipients"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "version" = (item0["action"]["version"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["version"]["odata_type"], "newVersion" = item0["action"]["version"]["newVersion"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }), "actor" = item0["actor"], "driveItem" = item0["driveItem"], "listItem" = item0["listItem"], "times" = (item0["times"] == null ? null : { for key2, value2 in { "@odata.type" = item0["times"]["odata_type"], "lastRecordedDateTime" = item0["times"]["lastRecordedDateTime"], "observedDateTime" = item0["times"]["observedDateTime"], "recordedDateTime" = item0["times"]["recordedDateTime"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "analytics"           = var.analytics
    "contentType"         = (var.content_type == null ? null : { for key0, value0 in { "@odata.type" = var.content_type["odata_type"], "id" = var.content_type["id"], "name" = var.content_type["name"] } : key0 => value0 if value0 != null })
    "createdByUser"       = var.created_by_user
    "deleted"             = (var.deleted == null ? null : { for key0, value0 in { "@odata.type" = var.deleted["odata_type"], "state" = var.deleted["state"] } : key0 => value0 if value0 != null })
    "description"         = var.description
    "documentSetVersions" = (var.document_set_versions == null ? null : [for item0 in var.document_set_versions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comment" = item0["comment"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "fields" = item0["fields"], "items" = (item0["items"] == null ? null : [for item2 in item0["items"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "itemId" = item2["itemId"], "title" = item2["title"], "versionId" = item2["versionId"] } : key3 => value3 if value3 != null }) if item2 != null]), "shouldCaptureMinorVersion" = item0["shouldCaptureMinorVersion"] } : key1 => value1 if value1 != null }) if item0 != null])
    "driveItem"           = var.drive_item
    "fields"              = var.fields
    "lastModifiedByUser"  = var.last_modified_by_user
    "name"                = var.name
    "@odata.type"         = var.odata_type
    "parentReference"     = (var.parent_reference == null ? null : { for key0, value0 in { "@odata.type" = var.parent_reference["odata_type"], "driveType" = var.parent_reference["driveType"], "shareId" = var.parent_reference["shareId"], "siteId" = var.parent_reference["siteId"] } : key0 => value0 if value0 != null })
    "versions"            = (var.versions == null ? null : [for item0 in var.versions : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/sites/${urlencode(var.site_id)}/lists/${urlencode(var.list_id)}/items"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
