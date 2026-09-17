# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "analytics"       = var.analytics
    "content"         = var.content
    "description"     = var.description
    "fileSystemInfo"  = var.file_system_info
    "name"            = var.name
    "@odata.type"     = var.odata_type
    "parentReference" = var.parent_reference
    "retentionLabel"  = var.retention_label
    "root"            = var.root
    "subscriptions"   = (var.subscriptions == null ? null : [for item0 in var.subscriptions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "changeType" = item0["changeType"], "clientState" = item0["clientState"], "encryptionCertificate" = item0["encryptionCertificate"], "encryptionCertificateId" = item0["encryptionCertificateId"], "expirationDateTime" = item0["expirationDateTime"], "includeResourceData" = item0["includeResourceData"], "latestSupportedTlsVersion" = item0["latestSupportedTlsVersion"], "lifecycleNotificationUrl" = item0["lifecycleNotificationUrl"], "notificationQueryOptions" = item0["notificationQueryOptions"], "notificationUrl" = item0["notificationUrl"], "notificationUrlAppId" = item0["notificationUrlAppId"], "resource" = item0["resource"] } : key1 => value1 if value1 != null }) if item0 != null])
    "webDavUrl"       = var.web_dav_url
    "workbook"        = var.workbook
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
