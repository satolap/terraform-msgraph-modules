# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_catalog_id       = "test-parent-id"
    access_package_resource_role_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackageCatalogs/test-parent-id/accessPackageResourceRoles/test-parent-id/accessPackageResource/accessPackageResourceRoles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessPackageResource", "description", "displayName", "originId", "originSystem", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_catalog_id       = "test-parent-id"
    access_package_resource_role_id = "test-parent-id"
    description                     = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_package_catalog_id       = "test-parent-id"
    access_package_resource_role_id = "test-parent-id"
    type                            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.type]
}
