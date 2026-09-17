# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_id                   = "test-parent-id"
    access_package_assignment_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackages/test-parent-id/accessPackageAssignmentPolicies/test-parent-id/customExtensionHandlers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["customExtension", "stage"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_package_id                   = "test-parent-id"
    access_package_assignment_policy_id = "test-parent-id"
    stage                               = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.stage]
}
