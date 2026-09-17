# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "subscriptions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["changeType", "clientState", "encryptionCertificate", "encryptionCertificateId", "expirationDateTime", "includeResourceData", "latestSupportedTlsVersion", "lifecycleNotificationUrl", "notificationContentType", "notificationQueryOptions", "notificationUrl", "notificationUrlAppId", "resource", "vapidPublicKey", "webPushEncryptionP256dhPublicKey", "webPushEncryptionSecret"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    change_type           = "example"
    include_resource_data = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["changeType"]) == jsonencode("example")
    error_message = "changeType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["includeResourceData"]) == jsonencode(false)
    error_message = "includeResourceData must preserve typed values and omit nested nulls."
  }
}
