# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "changeType"                       = var.changeType
    "expirationDateTime"               = var.expirationDateTime
    "notificationUrl"                  = var.notificationUrl
    "resource"                         = var.resource
    "clientState"                      = var.clientState
    "encryptionCertificate"            = var.encryptionCertificate
    "encryptionCertificateId"          = var.encryptionCertificateId
    "includeResourceData"              = var.includeResourceData
    "latestSupportedTlsVersion"        = var.latestSupportedTlsVersion
    "lifecycleNotificationUrl"         = var.lifecycleNotificationUrl
    "notificationQueryOptions"         = var.notificationQueryOptions
    "notificationUrlAppId"             = var.notificationUrlAppId
    "@odata.type"                      = var.odata_type
    "vapidPublicKey"                   = var.vapidPublicKey
    "webPushEncryptionP256dhPublicKey" = var.webPushEncryptionP256dhPublicKey
    "webPushEncryptionSecret"          = var.webPushEncryptionSecret
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "subscriptions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]
  }
}

# Inputs that Microsoft Graph cannot update in place; a change replaces msgraph_resource.this. Makes no API call.
resource "terraform_data" "immutable" {
  input = {
    "@odata.type"                      = var.odata_type != null ? var.odata_type : lookup(var.additional_properties, "@odata.type", null)
    "changeType"                       = var.changeType != null ? var.changeType : lookup(var.additional_properties, "changeType", null)
    "clientState"                      = var.clientState != null ? var.clientState : lookup(var.additional_properties, "clientState", null)
    "encryptionCertificate"            = var.encryptionCertificate != null ? var.encryptionCertificate : lookup(var.additional_properties, "encryptionCertificate", null)
    "encryptionCertificateId"          = var.encryptionCertificateId != null ? var.encryptionCertificateId : lookup(var.additional_properties, "encryptionCertificateId", null)
    "includeResourceData"              = var.includeResourceData != null ? var.includeResourceData : lookup(var.additional_properties, "includeResourceData", null)
    "latestSupportedTlsVersion"        = var.latestSupportedTlsVersion != null ? var.latestSupportedTlsVersion : lookup(var.additional_properties, "latestSupportedTlsVersion", null)
    "lifecycleNotificationUrl"         = var.lifecycleNotificationUrl != null ? var.lifecycleNotificationUrl : lookup(var.additional_properties, "lifecycleNotificationUrl", null)
    "notificationQueryOptions"         = var.notificationQueryOptions != null ? var.notificationQueryOptions : lookup(var.additional_properties, "notificationQueryOptions", null)
    "notificationUrlAppId"             = var.notificationUrlAppId != null ? var.notificationUrlAppId : lookup(var.additional_properties, "notificationUrlAppId", null)
    "resource"                         = var.resource != null ? var.resource : lookup(var.additional_properties, "resource", null)
    "vapidPublicKey"                   = var.vapidPublicKey != null ? var.vapidPublicKey : lookup(var.additional_properties, "vapidPublicKey", null)
    "webPushEncryptionP256dhPublicKey" = var.webPushEncryptionP256dhPublicKey != null ? var.webPushEncryptionP256dhPublicKey : lookup(var.additional_properties, "webPushEncryptionP256dhPublicKey", null)
    "webPushEncryptionSecret"          = var.webPushEncryptionSecret != null ? var.webPushEncryptionSecret : lookup(var.additional_properties, "webPushEncryptionSecret", null)
    "additional_properties"            = { for key, value in var.additional_properties : key => value if !contains(["@odata.type", "changeType", "clientState", "encryptionCertificate", "encryptionCertificateId", "expirationDateTime", "includeResourceData", "latestSupportedTlsVersion", "lifecycleNotificationUrl", "notificationQueryOptions", "notificationUrl", "notificationUrlAppId", "resource", "vapidPublicKey", "webPushEncryptionP256dhPublicKey", "webPushEncryptionSecret"], key) ? value != null : false }
  }
}
