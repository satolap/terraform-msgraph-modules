# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activities"         = (var.activities == null ? null : [for item0 in var.activities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = (item0["action"] == null ? null : { for key2, value2 in { "@odata.type" = item0["action"]["odata_type"], "comment" = (item0["action"]["comment"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["comment"]["odata_type"], "isReply" = item0["action"]["comment"]["isReply"], "parentAuthor" = item0["action"]["comment"]["parentAuthor"], "participants" = (item0["action"]["comment"]["participants"] == null ? null : [for item4 in item0["action"]["comment"]["participants"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "create" = item0["action"]["create"], "delete" = (item0["action"]["delete"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["delete"]["odata_type"], "name" = item0["action"]["delete"]["name"], "objectType" = item0["action"]["delete"]["objectType"] } : key3 => value3 if value3 != null }), "edit" = item0["action"]["edit"], "mention" = (item0["action"]["mention"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["mention"]["odata_type"], "mentionees" = (item0["action"]["mention"]["mentionees"] == null ? null : [for item4 in item0["action"]["mention"]["mentionees"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "move" = (item0["action"]["move"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["move"]["odata_type"], "from" = item0["action"]["move"]["from"], "to" = item0["action"]["move"]["to"] } : key3 => value3 if value3 != null }), "rename" = (item0["action"]["rename"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["rename"]["odata_type"], "newName" = item0["action"]["rename"]["newName"], "oldName" = item0["action"]["rename"]["oldName"] } : key3 => value3 if value3 != null }), "restore" = item0["action"]["restore"], "share" = (item0["action"]["share"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["share"]["odata_type"], "recipients" = (item0["action"]["share"]["recipients"] == null ? null : [for item4 in item0["action"]["share"]["recipients"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "version" = (item0["action"]["version"] == null ? null : { for key3, value3 in { "@odata.type" = item0["action"]["version"]["odata_type"], "newVersion" = item0["action"]["version"]["newVersion"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }), "actor" = item0["actor"], "driveItem" = item0["driveItem"], "listItem" = item0["listItem"], "times" = (item0["times"] == null ? null : { for key2, value2 in { "@odata.type" = item0["times"]["odata_type"], "lastRecordedDateTime" = item0["times"]["lastRecordedDateTime"], "observedDateTime" = item0["times"]["observedDateTime"], "recordedDateTime" = item0["times"]["recordedDateTime"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "analytics"          = var.analytics
    "content"            = var.content
    "contentStream"      = var.content_stream
    "createdByUser"      = var.created_by_user
    "description"        = var.description
    "extensions"         = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "fileSystemInfo"     = (var.file_system_info == null ? null : { for key0, value0 in { "@odata.type" = var.file_system_info["odata_type"], "createdDateTime" = var.file_system_info["createdDateTime"], "lastAccessedDateTime" = var.file_system_info["lastAccessedDateTime"], "lastModifiedDateTime" = var.file_system_info["lastModifiedDateTime"] } : key0 => value0 if value0 != null })
    "lastModifiedByUser" = var.last_modified_by_user
    "media"              = (var.media == null ? null : { for key0, value0 in { "@odata.type" = var.media["odata_type"], "isTranscriptionShown" = var.media["isTranscriptionShown"] } : key0 => value0 if value0 != null })
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "parentReference"    = (var.parent_reference == null ? null : { for key0, value0 in { "@odata.type" = var.parent_reference["odata_type"], "driveType" = var.parent_reference["driveType"], "shareId" = var.parent_reference["shareId"], "siteId" = var.parent_reference["siteId"] } : key0 => value0 if value0 != null })
    "retentionLabel"     = var.retention_label
    "root"               = var.root
    "subscriptions"      = (var.subscriptions == null ? null : [for item0 in var.subscriptions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "changeType" = item0["changeType"], "clientState" = item0["clientState"], "encryptionCertificate" = item0["encryptionCertificate"], "encryptionCertificateId" = item0["encryptionCertificateId"], "expirationDateTime" = item0["expirationDateTime"], "includeResourceData" = item0["includeResourceData"], "latestSupportedTlsVersion" = item0["latestSupportedTlsVersion"], "lifecycleNotificationUrl" = item0["lifecycleNotificationUrl"], "notificationContentType" = item0["notificationContentType"], "notificationQueryOptions" = item0["notificationQueryOptions"], "notificationUrl" = item0["notificationUrl"], "notificationUrlAppId" = item0["notificationUrlAppId"], "resource" = item0["resource"], "vapidPublicKey" = item0["vapidPublicKey"], "webPushEncryptionP256dhPublicKey" = item0["webPushEncryptionP256dhPublicKey"], "webPushEncryptionSecret" = item0["webPushEncryptionSecret"] } : key1 => value1 if value1 != null }) if item0 != null])
    "webDavUrl"          = var.web_dav_url
    "workbook"           = var.workbook
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
