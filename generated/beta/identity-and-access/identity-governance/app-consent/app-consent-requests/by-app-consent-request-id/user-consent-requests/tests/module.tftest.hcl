# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    app_consent_request_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/appConsent/appConsentRequests/test-parent-id/userConsentRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["approval", "approvalId", "completedDateTime", "createdBy", "createdDateTime", "customData", "reason", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_consent_request_id = "test-parent-id"
    approval_id            = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["approvalId"]) == jsonencode("example")
    error_message = "approvalId must preserve typed values and omit nested nulls."
  }
}
