# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "changeType"                = var.change_type
    "expirationDateTime"        = var.expiration_date_time
    "notificationUrl"           = var.notification_url
    "resource"                  = var.resource
    "clientState"               = var.client_state
    "encryptionCertificate"     = var.encryption_certificate
    "encryptionCertificateId"   = var.encryption_certificate_id
    "includeResourceData"       = var.include_resource_data
    "latestSupportedTlsVersion" = var.latest_supported_tls_version
    "lifecycleNotificationUrl"  = var.lifecycle_notification_url
    "notificationQueryOptions"  = var.notification_query_options
    "notificationUrlAppId"      = var.notification_url_app_id
    "@odata.type"               = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "subscriptions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]
  }
}

# Inputs that Microsoft Graph cannot update in place; a change replaces msgraph_resource.this. Makes no API call.
resource "terraform_data" "immutable" {
  input = {
    "@odata.type"               = var.odata_type != null ? var.odata_type : lookup(var.additional_properties, "@odata.type", null)
    "changeType"                = var.change_type != null ? var.change_type : lookup(var.additional_properties, "changeType", null)
    "clientState"               = var.client_state != null ? var.client_state : lookup(var.additional_properties, "clientState", null)
    "encryptionCertificate"     = var.encryption_certificate != null ? var.encryption_certificate : lookup(var.additional_properties, "encryptionCertificate", null)
    "encryptionCertificateId"   = var.encryption_certificate_id != null ? var.encryption_certificate_id : lookup(var.additional_properties, "encryptionCertificateId", null)
    "includeResourceData"       = var.include_resource_data != null ? var.include_resource_data : lookup(var.additional_properties, "includeResourceData", null)
    "latestSupportedTlsVersion" = var.latest_supported_tls_version != null ? var.latest_supported_tls_version : lookup(var.additional_properties, "latestSupportedTlsVersion", null)
    "lifecycleNotificationUrl"  = var.lifecycle_notification_url != null ? var.lifecycle_notification_url : lookup(var.additional_properties, "lifecycleNotificationUrl", null)
    "notificationQueryOptions"  = var.notification_query_options != null ? var.notification_query_options : lookup(var.additional_properties, "notificationQueryOptions", null)
    "notificationUrlAppId"      = var.notification_url_app_id != null ? var.notification_url_app_id : lookup(var.additional_properties, "notificationUrlAppId", null)
    "resource"                  = var.resource != null ? var.resource : lookup(var.additional_properties, "resource", null)
    "additional_properties"     = { for key, value in var.additional_properties : key => value if !contains(["@odata.type", "changeType", "clientState", "encryptionCertificate", "encryptionCertificateId", "expirationDateTime", "includeResourceData", "latestSupportedTlsVersion", "lifecycleNotificationUrl", "notificationQueryOptions", "notificationUrl", "notificationUrlAppId", "resource"], key) ? value != null : false }
  }
}
