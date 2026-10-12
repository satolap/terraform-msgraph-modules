# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/vppTokens"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appleId", "automaticallyUpdateApps", "countryOrRegion", "expirationDateTime", "lastModifiedDateTime", "lastSyncDateTime", "lastSyncStatus", "organizationName", "state", "token", "vppTokenAccountType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    apple_id                  = "example"
    automatically_update_apps = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appleId"]) == jsonencode("example")
    error_message = "appleId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["automaticallyUpdateApps"]) == jsonencode(false)
    error_message = "automaticallyUpdateApps must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    last_sync_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.last_sync_status]
}
