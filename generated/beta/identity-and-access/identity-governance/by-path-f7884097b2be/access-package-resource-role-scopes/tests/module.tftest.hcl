# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_assignment_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackageAssignments/test-parent-id/accessPackage/accessPackageResourceRoleScopes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessPackageResourceScope", "createdBy", "createdDateTime", "modifiedBy", "modifiedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_assignment_id = "test-parent-id"
    created_by                   = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdBy"]) == jsonencode("example")
    error_message = "createdBy must preserve typed values and omit nested nulls."
  }
}
