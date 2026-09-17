# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "changeType"                       = var.change_type
    "clientState"                      = var.client_state
    "encryptionCertificate"            = var.encryption_certificate
    "encryptionCertificateId"          = var.encryption_certificate_id
    "expirationDateTime"               = var.expiration_date_time
    "includeResourceData"              = var.include_resource_data
    "latestSupportedTlsVersion"        = var.latest_supported_tls_version
    "lifecycleNotificationUrl"         = var.lifecycle_notification_url
    "notificationContentType"          = var.notification_content_type
    "notificationQueryOptions"         = var.notification_query_options
    "notificationUrl"                  = var.notification_url
    "notificationUrlAppId"             = var.notification_url_app_id
    "@odata.type"                      = var.odata_type
    "resource"                         = var.resource
    "vapidPublicKey"                   = var.vapid_public_key
    "webPushEncryptionP256dhPublicKey" = var.web_push_encryption_p256dh_public_key
    "webPushEncryptionSecret"          = var.web_push_encryption_secret
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/lists/${urlencode(var.list_id)}/subscriptions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
