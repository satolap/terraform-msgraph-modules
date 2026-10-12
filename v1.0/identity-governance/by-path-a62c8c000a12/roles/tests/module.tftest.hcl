# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_resource_role_scope_id = "test-parent-id"
    access_package_resource_scope_id      = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/resourceRoleScopes/test-parent-id/role/resource/scopes/test-parent-id/resource/roles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "originId", "originSystem", "resource", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_resource_role_scope_id = "test-parent-id"
    access_package_resource_scope_id      = "test-parent-id"
    description                           = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_package_resource_role_scope_id = "test-parent-id"
    access_package_resource_scope_id      = "test-parent-id"
    type                                  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.type]
}
