# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    service_principal_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "servicePrincipals/test-parent-id/delegatedPermissionClassifications"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["classification", "permissionId", "permissionName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    service_principal_id = "test-parent-id"
    permission_id        = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["permissionId"]) == jsonencode("example")
    error_message = "permissionId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    service_principal_id = "test-parent-id"
    classification       = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.classification]
}
