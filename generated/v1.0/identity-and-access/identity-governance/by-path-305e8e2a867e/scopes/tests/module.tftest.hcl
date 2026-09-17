# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_id                     = "test-parent-id"
    access_package_resource_role_scope_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackages/test-parent-id/resourceRoleScopes/test-parent-id/scope/resource/scopes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "isRootScope", "originId", "originSystem", "resource"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_id                     = "test-parent-id"
    access_package_resource_role_scope_id = "test-parent-id"
    description                           = "example"
    is_root_scope                         = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isRootScope"]) == jsonencode(false)
    error_message = "isRootScope must preserve typed values and omit nested nulls."
  }
}
