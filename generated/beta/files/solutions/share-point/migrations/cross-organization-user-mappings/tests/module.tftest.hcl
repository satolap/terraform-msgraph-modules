# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "solutions/sharePoint/migrations/crossOrganizationUserMappings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deleted", "sourceOrganizationId", "sourceUserIdentity", "targetUserIdentity", "targetUserMigrationData", "userType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    source_organization_id = "00000000-0000-0000-0000-000000000001"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sourceOrganizationId"]) == jsonencode("00000000-0000-0000-0000-000000000001")
    error_message = "sourceOrganizationId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.user_type]
}
