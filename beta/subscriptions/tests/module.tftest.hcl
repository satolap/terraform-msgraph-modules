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
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
  }

  assert {
    condition     = msgraph_resource.this.url == "subscriptions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["clientState", "encryptionCertificate", "encryptionCertificateId", "includeResourceData", "latestSupportedTlsVersion", "lifecycleNotificationUrl", "notificationContentType", "notificationQueryOptions", "notificationUrlAppId", "vapidPublicKey", "webPushEncryptionP256dhPublicKey", "webPushEncryptionSecret"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
    select_response    = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    changeType          = "example"
    expirationDateTime  = "2026-01-01T00:00:00Z"
    notificationUrl     = "example"
    resource            = "example"
    clientState         = "example"
    includeResourceData = false
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
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
  }

  assert {
    condition     = msgraph_resource.this.id != ""
    error_message = "The baseline must create the object."
  }
}

run "update_in_place_expirationDateTime" {
  command = apply

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z-changed"
    notificationUrl    = "example"
    resource           = "example"
  }

  assert {
    condition     = msgraph_resource.this.id == run.replacement_baseline.id
    error_message = "Changing expirationDateTime must update the object in place."
  }
}

run "update_in_place_notificationUrl" {
  command = apply

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z-changed"
    notificationUrl    = "example-changed"
    resource           = "example"
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_expirationDateTime.id
    error_message = "Changing notificationUrl must update the object in place."
  }
}

run "replace_through_additional_properties" {
  command = apply

  variables {
    changeType            = "example"
    expirationDateTime    = "2026-01-01T00:00:00Z-changed"
    notificationUrl       = "example-changed"
    resource              = "example"
    additional_properties = { "clientState" = "example" }
  }

  assert {
    condition     = msgraph_resource.this.id != run.update_in_place_notificationUrl.id
    error_message = "clientState in additional_properties must replace the object."
  }
}

run "replace_through_unlisted_additional_property" {
  command = apply

  variables {
    changeType            = "example"
    expirationDateTime    = "2026-01-01T00:00:00Z-changed"
    notificationUrl       = "example-changed"
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
    changeType            = "example"
    expirationDateTime    = "2026-01-01T00:00:00Z-changed"
    notificationUrl       = "example-changed"
    resource              = "example"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id == run.replace_through_unlisted_additional_property.id
    error_message = "nullProperty set to null is omitted from the request and must keep the object."
  }
}

run "replace_on_changeType" {
  command = apply

  variables {
    changeType            = "example-changed"
    expirationDateTime    = "2026-01-01T00:00:00Z-changed"
    notificationUrl       = "example-changed"
    resource              = "example"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id != run.keep_object_for_null_additional_property.id
    error_message = "Changing changeType must replace the object."
  }
}

run "replace_on_resource" {
  command = apply

  variables {
    changeType            = "example-changed"
    expirationDateTime    = "2026-01-01T00:00:00Z-changed"
    notificationUrl       = "example-changed"
    resource              = "example-changed"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_changeType.id
    error_message = "Changing resource must replace the object."
  }
}

run "replace_on_clientState" {
  command = apply

  variables {
    changeType            = "example-changed"
    expirationDateTime    = "2026-01-01T00:00:00Z-changed"
    notificationUrl       = "example-changed"
    resource              = "example-changed"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState           = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_resource.id
    error_message = "Changing clientState must replace the object."
  }
}

run "replace_on_encryptionCertificate" {
  command = apply

  variables {
    changeType            = "example-changed"
    expirationDateTime    = "2026-01-01T00:00:00Z-changed"
    notificationUrl       = "example-changed"
    resource              = "example-changed"
    additional_properties = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState           = "example-changed"
    encryptionCertificate = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_clientState.id
    error_message = "Changing encryptionCertificate must replace the object."
  }
}

run "replace_on_encryptionCertificateId" {
  command = apply

  variables {
    changeType              = "example-changed"
    expirationDateTime      = "2026-01-01T00:00:00Z-changed"
    notificationUrl         = "example-changed"
    resource                = "example-changed"
    additional_properties   = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState             = "example-changed"
    encryptionCertificate   = "example-changed"
    encryptionCertificateId = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_encryptionCertificate.id
    error_message = "Changing encryptionCertificateId must replace the object."
  }
}

run "replace_on_includeResourceData" {
  command = apply

  variables {
    changeType              = "example-changed"
    expirationDateTime      = "2026-01-01T00:00:00Z-changed"
    notificationUrl         = "example-changed"
    resource                = "example-changed"
    additional_properties   = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState             = "example-changed"
    encryptionCertificate   = "example-changed"
    encryptionCertificateId = "example-changed"
    includeResourceData     = true
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_encryptionCertificateId.id
    error_message = "Changing includeResourceData must replace the object."
  }
}

run "replace_on_latestSupportedTlsVersion" {
  command = apply

  variables {
    changeType                = "example-changed"
    expirationDateTime        = "2026-01-01T00:00:00Z-changed"
    notificationUrl           = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState               = "example-changed"
    encryptionCertificate     = "example-changed"
    encryptionCertificateId   = "example-changed"
    includeResourceData       = true
    latestSupportedTlsVersion = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_includeResourceData.id
    error_message = "Changing latestSupportedTlsVersion must replace the object."
  }
}

run "replace_on_lifecycleNotificationUrl" {
  command = apply

  variables {
    changeType                = "example-changed"
    expirationDateTime        = "2026-01-01T00:00:00Z-changed"
    notificationUrl           = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState               = "example-changed"
    encryptionCertificate     = "example-changed"
    encryptionCertificateId   = "example-changed"
    includeResourceData       = true
    latestSupportedTlsVersion = "example-changed"
    lifecycleNotificationUrl  = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_latestSupportedTlsVersion.id
    error_message = "Changing lifecycleNotificationUrl must replace the object."
  }
}

run "replace_on_notificationContentType" {
  command = apply

  variables {
    changeType                = "example-changed"
    expirationDateTime        = "2026-01-01T00:00:00Z-changed"
    notificationUrl           = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState               = "example-changed"
    encryptionCertificate     = "example-changed"
    encryptionCertificateId   = "example-changed"
    includeResourceData       = true
    latestSupportedTlsVersion = "example-changed"
    lifecycleNotificationUrl  = "example-changed"
    notificationContentType   = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_lifecycleNotificationUrl.id
    error_message = "Changing notificationContentType must replace the object."
  }
}

run "replace_on_notificationQueryOptions" {
  command = apply

  variables {
    changeType                = "example-changed"
    expirationDateTime        = "2026-01-01T00:00:00Z-changed"
    notificationUrl           = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState               = "example-changed"
    encryptionCertificate     = "example-changed"
    encryptionCertificateId   = "example-changed"
    includeResourceData       = true
    latestSupportedTlsVersion = "example-changed"
    lifecycleNotificationUrl  = "example-changed"
    notificationContentType   = "example-changed"
    notificationQueryOptions  = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_notificationContentType.id
    error_message = "Changing notificationQueryOptions must replace the object."
  }
}

run "replace_on_notificationUrlAppId" {
  command = apply

  variables {
    changeType                = "example-changed"
    expirationDateTime        = "2026-01-01T00:00:00Z-changed"
    notificationUrl           = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState               = "example-changed"
    encryptionCertificate     = "example-changed"
    encryptionCertificateId   = "example-changed"
    includeResourceData       = true
    latestSupportedTlsVersion = "example-changed"
    lifecycleNotificationUrl  = "example-changed"
    notificationContentType   = "example-changed"
    notificationQueryOptions  = "example-changed"
    notificationUrlAppId      = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_notificationQueryOptions.id
    error_message = "Changing notificationUrlAppId must replace the object."
  }
}

run "replace_on_vapidPublicKey" {
  command = apply

  variables {
    changeType                = "example-changed"
    expirationDateTime        = "2026-01-01T00:00:00Z-changed"
    notificationUrl           = "example-changed"
    resource                  = "example-changed"
    additional_properties     = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState               = "example-changed"
    encryptionCertificate     = "example-changed"
    encryptionCertificateId   = "example-changed"
    includeResourceData       = true
    latestSupportedTlsVersion = "example-changed"
    lifecycleNotificationUrl  = "example-changed"
    notificationContentType   = "example-changed"
    notificationQueryOptions  = "example-changed"
    notificationUrlAppId      = "example-changed"
    vapidPublicKey            = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_notificationUrlAppId.id
    error_message = "Changing vapidPublicKey must replace the object."
  }
}

run "replace_on_webPushEncryptionP256dhPublicKey" {
  command = apply

  variables {
    changeType                       = "example-changed"
    expirationDateTime               = "2026-01-01T00:00:00Z-changed"
    notificationUrl                  = "example-changed"
    resource                         = "example-changed"
    additional_properties            = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState                      = "example-changed"
    encryptionCertificate            = "example-changed"
    encryptionCertificateId          = "example-changed"
    includeResourceData              = true
    latestSupportedTlsVersion        = "example-changed"
    lifecycleNotificationUrl         = "example-changed"
    notificationContentType          = "example-changed"
    notificationQueryOptions         = "example-changed"
    notificationUrlAppId             = "example-changed"
    vapidPublicKey                   = "example-changed"
    webPushEncryptionP256dhPublicKey = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_vapidPublicKey.id
    error_message = "Changing webPushEncryptionP256dhPublicKey must replace the object."
  }
}

run "replace_on_webPushEncryptionSecret" {
  command = apply

  variables {
    changeType                       = "example-changed"
    expirationDateTime               = "2026-01-01T00:00:00Z-changed"
    notificationUrl                  = "example-changed"
    resource                         = "example-changed"
    additional_properties            = { "clientState" = "example", "unlistedProperty" = "example", "nullProperty" = null }
    clientState                      = "example-changed"
    encryptionCertificate            = "example-changed"
    encryptionCertificateId          = "example-changed"
    includeResourceData              = true
    latestSupportedTlsVersion        = "example-changed"
    lifecycleNotificationUrl         = "example-changed"
    notificationContentType          = "example-changed"
    notificationQueryOptions         = "example-changed"
    notificationUrlAppId             = "example-changed"
    vapidPublicKey                   = "example-changed"
    webPushEncryptionP256dhPublicKey = "example-changed"
    webPushEncryptionSecret          = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_webPushEncryptionP256dhPublicKey.id
    error_message = "Changing webPushEncryptionSecret must replace the object."
  }
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
    timeouts           = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
    timeouts           = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
    timeouts           = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    changeType         = "example"
    expirationDateTime = "2026-01-01T00:00:00Z"
    notificationUrl    = "example"
    resource           = "example"
    timeouts           = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
