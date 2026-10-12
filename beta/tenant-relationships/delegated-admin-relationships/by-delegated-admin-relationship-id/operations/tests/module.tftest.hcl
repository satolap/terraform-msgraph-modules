# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    delegated_admin_relationship_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/delegatedAdminRelationships/test-parent-id/operations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["operationType", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    delegated_admin_relationship_id = "test-parent-id"
    operation_type                  = "delegatedAdminAccessAssignmentUpdate"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["operationType"]) == jsonencode("delegatedAdminAccessAssignmentUpdate")
    error_message = "operationType must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    delegated_admin_relationship_id = "test-parent-id"
    operation_type                  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.operation_type]
}
