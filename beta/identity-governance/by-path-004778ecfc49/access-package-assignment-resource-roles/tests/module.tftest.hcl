# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_assignment_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackageAssignments/test-parent-id/accessPackageAssignmentResourceRoles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessPackageResourceRole", "accessPackageResourceScope", "originId", "originSystem", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_assignment_id = "test-parent-id"
    origin_id                    = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["originId"]) == jsonencode("example")
    error_message = "originId must preserve typed values and omit nested nulls."
  }
}
