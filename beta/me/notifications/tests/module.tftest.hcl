# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/notifications"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayTimeToLive", "expirationDateTime", "groupName", "payload", "priority", "targetHostName", "targetPolicy"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    expiration_date_time = "2026-01-01T00:00:00Z"
    display_time_to_live = -2147483648
    payload              = { "rawContent" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["expirationDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "expirationDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayTimeToLive"]) == jsonencode(-2147483648)
    error_message = "displayTimeToLive must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["payload"]) == jsonencode({ "@odata.type" = "#microsoft.graph.payloadTypes" })
    error_message = "payload must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    priority = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.priority]
}
