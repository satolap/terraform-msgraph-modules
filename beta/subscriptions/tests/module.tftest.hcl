# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      output = { response = {} }
    }
  }
}

run "minimal_request" {
  command = plan

  variables {
    change_type          = "example"
    expiration_date_time = "2026-01-01T00:00:00Z"
    notification_url     = "example"
    resource             = "example"
  }

  assert {
    condition     = msgraph_resource.this.url == "subscriptions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["clientState", "encryptionCertificate", "encryptionCertificateId", "includeResourceData", "latestSupportedTlsVersion", "lifecycleNotificationUrl", "notificationContentType", "notificationQueryOptions", "notificationUrlAppId", "vapidPublicKey", "webPushEncryptionP256dhPublicKey", "webPushEncryptionSecret"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    change_type           = "example"
    expiration_date_time  = "2026-01-01T00:00:00Z"
    notification_url      = "example"
    resource              = "example"
    client_state          = "example"
    include_resource_data = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["changeType"]) == jsonencode("example")
    error_message = "changeType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["expirationDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "expirationDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["notificationUrl"]) == jsonencode("example")
    error_message = "notificationUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resource"]) == jsonencode("example")
    error_message = "resource must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clientState"]) == jsonencode("example")
    error_message = "clientState must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["includeResourceData"]) == jsonencode(false)
    error_message = "includeResourceData must preserve typed values and omit nested nulls."
  }
}

# Offline replacement tests: each apply changes one input. An unchanged id is an in-place
# update and a new id is a replacement.

run "replacement_baseline" {
  command = apply

  variables {
    change_type          = "example"
    expiration_date_time = "2026-01-01T00:00:00Z"
    notification_url     = "example"
    resource             = "example"
  }

  assert {
    condition     = msgraph_resource.this.id != ""
    error_message = "The baseline must create the object."
  }
}

run "update_in_place_expiration_date_time" {
  command = apply

  variables {
    change_type          = "example"
    expiration_date_time = "2026-01-01T00:00:00Z-changed"
    notification_url     = "example"
    resource             = "example"
  }

  assert {
    condition     = msgraph_resource.this.id == run.replacement_baseline.id
    error_message = "Changing expiration_date_time must update the object in place."
  }
}

run "update_in_place_notification_url" {
  command = apply

  variables {
    change_type          = "example"
    expiration_date_time = "2026-01-01T00:00:00Z-changed"
    notification_url     = "example-changed"
    resource             = "example"
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_expiration_date_time.id
    error_message = "Changing notification_url must update the object in place."
  }
}

run "replace_through_additional_properties" {
  command = apply

  variables {
    change_type           = "example"
    expiration_date_time  = "2026-01-01T00:00:00Z-changed"
    notification_url      = "example-changed"
    resource              = "example"
    additional_properties = { "clientState" = "example" }
  }

  assert {
    condition     = msgraph_resource.this.id != run.update_in_place_notification_url.id
    error_message = "clientState in additional_properties must replace the object."
  }
}

run "replace_through_unlisted_additional_property" {
  command = apply

  variables {
    change_type           = "example"
    expiration_date_time  = "2026-01-01T00:00:00Z-changed"
    notification_url      = "example-changed"
    resource              = "example"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example" }
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_through_additional_properties.id
    error_message = "unlistedProperty in additional_properties must replace the object."
  }
}

run "keep_object_for_null_additional_property" {
  command = apply

  variables {
    change_type           = "example"
    expiration_date_time  = "2026-01-01T00:00:00Z-changed"
    notification_url      = "example-changed"
    resource              = "example"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id == run.replace_through_unlisted_additional_property.id
    error_message = "nullProperty set to null is omitted from the request and must keep the object."
  }
}

run "replace_on_change_type" {
  command = apply

  variables {
    change_type           = "example-changed"
    expiration_date_time  = "2026-01-01T00:00:00Z-changed"
    notification_url      = "example-changed"
    resource              = "example"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id != run.keep_object_for_null_additional_property.id
    error_message = "Changing change_type must replace the object."
  }
}

run "replace_on_resource" {
  command = apply

  variables {
    change_type           = "example-changed"
    expiration_date_time  = "2026-01-01T00:00:00Z-changed"
    notification_url      = "example-changed"
    resource              = "example-changed"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_change_type.id
    error_message = "Changing resource must replace the object."
  }
}

run "replace_on_client_state" {
  command = apply

  variables {
    change_type           = "example-changed"
    expiration_date_time  = "2026-01-01T00:00:00Z-changed"
    notification_url      = "example-changed"
    resource              = "example-changed"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state          = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_resource.id
    error_message = "Changing client_state must replace the object."
  }
}

run "replace_on_encryption_certificate" {
  command = apply

  variables {
    change_type            = "example-changed"
    expiration_date_time   = "2026-01-01T00:00:00Z-changed"
    notification_url       = "example-changed"
    resource               = "example-changed"
    additional_properties  = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state           = "example-changed"
    encryption_certificate = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_client_state.id
    error_message = "Changing encryption_certificate must replace the object."
  }
}

run "replace_on_encryption_certificate_id" {
  command = apply

  variables {
    change_type               = "example-changed"
    expiration_date_time      = "2026-01-01T00:00:00Z-changed"
    notification_url          = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state              = "example-changed"
    encryption_certificate    = "example-changed"
    encryption_certificate_id = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_encryption_certificate.id
    error_message = "Changing encryption_certificate_id must replace the object."
  }
}

run "replace_on_include_resource_data" {
  command = apply

  variables {
    change_type               = "example-changed"
    expiration_date_time      = "2026-01-01T00:00:00Z-changed"
    notification_url          = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state              = "example-changed"
    encryption_certificate    = "example-changed"
    encryption_certificate_id = "example-changed"
    include_resource_data     = true
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_encryption_certificate_id.id
    error_message = "Changing include_resource_data must replace the object."
  }
}

run "replace_on_latest_supported_tls_version" {
  command = apply

  variables {
    change_type                  = "example-changed"
    expiration_date_time         = "2026-01-01T00:00:00Z-changed"
    notification_url             = "example-changed"
    resource                     = "example-changed"
    additional_properties        = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                 = "example-changed"
    encryption_certificate       = "example-changed"
    encryption_certificate_id    = "example-changed"
    include_resource_data        = true
    latest_supported_tls_version = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_include_resource_data.id
    error_message = "Changing latest_supported_tls_version must replace the object."
  }
}

run "replace_on_lifecycle_notification_url" {
  command = apply

  variables {
    change_type                  = "example-changed"
    expiration_date_time         = "2026-01-01T00:00:00Z-changed"
    notification_url             = "example-changed"
    resource                     = "example-changed"
    additional_properties        = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                 = "example-changed"
    encryption_certificate       = "example-changed"
    encryption_certificate_id    = "example-changed"
    include_resource_data        = true
    latest_supported_tls_version = "example-changed"
    lifecycle_notification_url   = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_latest_supported_tls_version.id
    error_message = "Changing lifecycle_notification_url must replace the object."
  }
}

run "replace_on_notification_content_type" {
  command = apply

  variables {
    change_type                  = "example-changed"
    expiration_date_time         = "2026-01-01T00:00:00Z-changed"
    notification_url             = "example-changed"
    resource                     = "example-changed"
    additional_properties        = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                 = "example-changed"
    encryption_certificate       = "example-changed"
    encryption_certificate_id    = "example-changed"
    include_resource_data        = true
    latest_supported_tls_version = "example-changed"
    lifecycle_notification_url   = "example-changed"
    notification_content_type    = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_lifecycle_notification_url.id
    error_message = "Changing notification_content_type must replace the object."
  }
}

run "replace_on_notification_query_options" {
  command = apply

  variables {
    change_type                  = "example-changed"
    expiration_date_time         = "2026-01-01T00:00:00Z-changed"
    notification_url             = "example-changed"
    resource                     = "example-changed"
    additional_properties        = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                 = "example-changed"
    encryption_certificate       = "example-changed"
    encryption_certificate_id    = "example-changed"
    include_resource_data        = true
    latest_supported_tls_version = "example-changed"
    lifecycle_notification_url   = "example-changed"
    notification_content_type    = "example-changed"
    notification_query_options   = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_notification_content_type.id
    error_message = "Changing notification_query_options must replace the object."
  }
}

run "replace_on_notification_url_app_id" {
  command = apply

  variables {
    change_type                  = "example-changed"
    expiration_date_time         = "2026-01-01T00:00:00Z-changed"
    notification_url             = "example-changed"
    resource                     = "example-changed"
    additional_properties        = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                 = "example-changed"
    encryption_certificate       = "example-changed"
    encryption_certificate_id    = "example-changed"
    include_resource_data        = true
    latest_supported_tls_version = "example-changed"
    lifecycle_notification_url   = "example-changed"
    notification_content_type    = "example-changed"
    notification_query_options   = "example-changed"
    notification_url_app_id      = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_notification_query_options.id
    error_message = "Changing notification_url_app_id must replace the object."
  }
}

run "replace_on_vapid_public_key" {
  command = apply

  variables {
    change_type                  = "example-changed"
    expiration_date_time         = "2026-01-01T00:00:00Z-changed"
    notification_url             = "example-changed"
    resource                     = "example-changed"
    additional_properties        = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                 = "example-changed"
    encryption_certificate       = "example-changed"
    encryption_certificate_id    = "example-changed"
    include_resource_data        = true
    latest_supported_tls_version = "example-changed"
    lifecycle_notification_url   = "example-changed"
    notification_content_type    = "example-changed"
    notification_query_options   = "example-changed"
    notification_url_app_id      = "example-changed"
    vapid_public_key             = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_notification_url_app_id.id
    error_message = "Changing vapid_public_key must replace the object."
  }
}

run "replace_on_web_push_encryption_p256dh_public_key" {
  command = apply

  variables {
    change_type                           = "example-changed"
    expiration_date_time                  = "2026-01-01T00:00:00Z-changed"
    notification_url                      = "example-changed"
    resource                              = "example-changed"
    additional_properties                 = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                          = "example-changed"
    encryption_certificate                = "example-changed"
    encryption_certificate_id             = "example-changed"
    include_resource_data                 = true
    latest_supported_tls_version          = "example-changed"
    lifecycle_notification_url            = "example-changed"
    notification_content_type             = "example-changed"
    notification_query_options            = "example-changed"
    notification_url_app_id               = "example-changed"
    vapid_public_key                      = "example-changed"
    web_push_encryption_p256dh_public_key = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_vapid_public_key.id
    error_message = "Changing web_push_encryption_p256dh_public_key must replace the object."
  }
}

run "replace_on_web_push_encryption_secret" {
  command = apply

  variables {
    change_type                           = "example-changed"
    expiration_date_time                  = "2026-01-01T00:00:00Z-changed"
    notification_url                      = "example-changed"
    resource                              = "example-changed"
    additional_properties                 = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    client_state                          = "example-changed"
    encryption_certificate                = "example-changed"
    encryption_certificate_id             = "example-changed"
    include_resource_data                 = true
    latest_supported_tls_version          = "example-changed"
    lifecycle_notification_url            = "example-changed"
    notification_content_type             = "example-changed"
    notification_query_options            = "example-changed"
    notification_url_app_id               = "example-changed"
    vapid_public_key                      = "example-changed"
    web_push_encryption_p256dh_public_key = "example-changed"
    web_push_encryption_secret            = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_web_push_encryption_p256dh_public_key.id
    error_message = "Changing web_push_encryption_secret must replace the object."
  }
}
