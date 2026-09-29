# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdByUser"      = var.created_by_user
    "description"        = var.description
    "driveItem"          = var.drive_item
    "items"              = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "activities" = (item0["activities"] == null ? null : [for item2 in item0["activities"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "action" = (item2["action"] == null ? null : { for key4, value4 in { "@odata.type" = item2["action"]["odata_type"], "comment" = item2["action"]["comment"], "create" = item2["action"]["create"], "delete" = item2["action"]["delete"], "edit" = item2["action"]["edit"], "mention" = item2["action"]["mention"], "move" = item2["action"]["move"], "rename" = item2["action"]["rename"], "restore" = item2["action"]["restore"], "share" = item2["action"]["share"], "version" = item2["action"]["version"] } : key4 => value4 if value4 != null }), "actor" = item2["actor"], "driveItem" = item2["driveItem"], "listItem" = item2["listItem"], "times" = (item2["times"] == null ? null : { for key4, value4 in { "@odata.type" = item2["times"]["odata_type"], "lastRecordedDateTime" = item2["times"]["lastRecordedDateTime"], "observedDateTime" = item2["times"]["observedDateTime"], "recordedDateTime" = item2["times"]["recordedDateTime"] } : key4 => value4 if value4 != null }) } : key3 => value3 if value3 != null }) if item2 != null]), "analytics" = item0["analytics"], "content" = item0["content"], "contentStream" = item0["contentStream"], "createdByUser" = item0["createdByUser"], "description" = item0["description"], "extensions" = (item0["extensions"] == null ? null : [for item2 in item0["extensions"] : item2 if item2 != null]), "fileSystemInfo" = (item0["fileSystemInfo"] == null ? null : { for key2, value2 in { "@odata.type" = item0["fileSystemInfo"]["odata_type"], "createdDateTime" = item0["fileSystemInfo"]["createdDateTime"], "lastAccessedDateTime" = item0["fileSystemInfo"]["lastAccessedDateTime"], "lastModifiedDateTime" = item0["fileSystemInfo"]["lastModifiedDateTime"] } : key2 => value2 if value2 != null }), "lastModifiedByUser" = item0["lastModifiedByUser"], "media" = (item0["media"] == null ? null : { for key2, value2 in { "@odata.type" = item0["media"]["odata_type"], "isTranscriptionShown" = item0["media"]["isTranscriptionShown"] } : key2 => value2 if value2 != null }), "name" = item0["name"], "parentReference" = (item0["parentReference"] == null ? null : { for key2, value2 in { "@odata.type" = item0["parentReference"]["odata_type"], "driveType" = item0["parentReference"]["driveType"], "shareId" = item0["parentReference"]["shareId"], "siteId" = item0["parentReference"]["siteId"] } : key2 => value2 if value2 != null }), "retentionLabel" = item0["retentionLabel"], "root" = item0["root"], "subscriptions" = (item0["subscriptions"] == null ? null : [for item2 in item0["subscriptions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "changeType" = item2["changeType"], "clientState" = item2["clientState"], "encryptionCertificate" = item2["encryptionCertificate"], "encryptionCertificateId" = item2["encryptionCertificateId"], "expirationDateTime" = item2["expirationDateTime"], "includeResourceData" = item2["includeResourceData"], "latestSupportedTlsVersion" = item2["latestSupportedTlsVersion"], "lifecycleNotificationUrl" = item2["lifecycleNotificationUrl"], "notificationContentType" = item2["notificationContentType"], "notificationQueryOptions" = item2["notificationQueryOptions"], "notificationUrl" = item2["notificationUrl"], "notificationUrlAppId" = item2["notificationUrlAppId"], "resource" = item2["resource"], "vapidPublicKey" = item2["vapidPublicKey"], "webPushEncryptionP256dhPublicKey" = item2["webPushEncryptionP256dhPublicKey"], "webPushEncryptionSecret" = item2["webPushEncryptionSecret"] } : key3 => value3 if value3 != null }) if item2 != null]), "webDavUrl" = item0["webDavUrl"], "workbook" = item0["workbook"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedByUser" = var.last_modified_by_user
    "list"               = var.list
    "listItem"           = var.list_item
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "owner"              = var.owner
    "parentReference"    = (var.parent_reference == null ? null : { for key0, value0 in { "@odata.type" = var.parent_reference["odata_type"], "driveType" = var.parent_reference["driveType"], "shareId" = var.parent_reference["shareId"], "siteId" = var.parent_reference["siteId"] } : key0 => value0 if value0 != null })
    "permission"         = var.permission
    "root"               = var.root
    "site"               = var.site
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "shares"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
