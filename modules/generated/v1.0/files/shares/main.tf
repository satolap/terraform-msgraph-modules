# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"     = var.description
    "driveItem"       = var.drive_item
    "items"           = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "analytics" = item0["analytics"], "content" = item0["content"], "description" = item0["description"], "fileSystemInfo" = item0["fileSystemInfo"], "name" = item0["name"], "parentReference" = item0["parentReference"], "retentionLabel" = item0["retentionLabel"], "root" = item0["root"], "subscriptions" = (item0["subscriptions"] == null ? null : [for item2 in item0["subscriptions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "changeType" = item2["changeType"], "clientState" = item2["clientState"], "encryptionCertificate" = item2["encryptionCertificate"], "encryptionCertificateId" = item2["encryptionCertificateId"], "expirationDateTime" = item2["expirationDateTime"], "includeResourceData" = item2["includeResourceData"], "latestSupportedTlsVersion" = item2["latestSupportedTlsVersion"], "lifecycleNotificationUrl" = item2["lifecycleNotificationUrl"], "notificationQueryOptions" = item2["notificationQueryOptions"], "notificationUrl" = item2["notificationUrl"], "notificationUrlAppId" = item2["notificationUrlAppId"], "resource" = item2["resource"] } : key3 => value3 if value3 != null }) if item2 != null]), "webDavUrl" = item0["webDavUrl"], "workbook" = item0["workbook"] } : key1 => value1 if value1 != null }) if item0 != null])
    "list"            = var.list
    "listItem"        = var.list_item
    "name"            = var.name
    "@odata.type"     = var.odata_type
    "owner"           = var.owner
    "parentReference" = var.parent_reference
    "permission"      = var.permission
    "root"            = var.root
    "site"            = var.site
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "shares"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
