# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activities"         = (var.activities == null ? null : [for item0 in var.activities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = item0["action"], "actor" = item0["actor"], "driveItem" = item0["driveItem"], "listItem" = item0["listItem"], "times" = item0["times"] } : key1 => value1 if value1 != null }) if item0 != null])
    "analytics"          = var.analytics
    "content"            = var.content
    "contentStream"      = var.content_stream
    "createdByUser"      = var.created_by_user
    "description"        = var.description
    "extensions"         = (var.extensions == null ? null : [for item0 in var.extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "fileSystemInfo"     = var.file_system_info
    "lastModifiedByUser" = var.last_modified_by_user
    "media"              = var.media
    "name"               = var.name
    "@odata.type"        = var.odata_type
    "parentReference"    = var.parent_reference
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
