# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

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
    condition     = alltrue([for key in ["clientState", "encryptionCertificate", "encryptionCertificateId", "includeResourceData", "latestSupportedTlsVersion", "lifecycleNotificationUrl", "notificationQueryOptions", "notificationUrlAppId"] : !contains(keys(msgraph_resource.this.body), key)])
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
