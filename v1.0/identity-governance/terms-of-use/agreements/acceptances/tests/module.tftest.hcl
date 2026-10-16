# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    agreement_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/termsOfUse/agreements/test-parent-id/acceptances"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["agreementFileId", "agreementId", "deviceDisplayName", "deviceId", "deviceOSType", "deviceOSVersion", "expirationDateTime", "recordedDateTime", "state", "userDisplayName", "userEmail", "userId", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    agreement_id      = "test-parent-id"
    agreement_file_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["agreementFileId"]) == jsonencode("example")
    error_message = "agreementFileId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    agreement_id = "test-parent-id"
    state        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
