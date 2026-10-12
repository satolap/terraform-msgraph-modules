# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/dataSharingConsents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["grantDateTime", "granted", "grantedByUpn", "grantedByUserId", "serviceDisplayName", "termsUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    grant_date_time = "2026-01-01T00:00:00Z"
    granted         = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["grantDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "grantDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["granted"]) == jsonencode(false)
    error_message = "granted must preserve typed values and omit nested nulls."
  }
}
