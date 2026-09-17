# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    agreement_id                   = "test-parent-id"
    agreement_file_localization_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/termsOfUse/agreements/test-parent-id/file/localizations/test-parent-id/versions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "displayName", "isMajorVersion"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    agreement_id                   = "test-parent-id"
    agreement_file_localization_id = "test-parent-id"
    created_date_time              = "2026-01-01T00:00:00Z"
    is_major_version               = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isMajorVersion"]) == jsonencode(false)
    error_message = "isMajorVersion must preserve typed values and omit nested nulls."
  }
}
