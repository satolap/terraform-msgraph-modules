# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "solutions/sharePoint/migrations/crossOrganizationGroupMappings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deleted", "groupType", "sourceGroupIdentity", "sourceOrganizationId", "targetGroupIdentity", "targetGroupMigrationData"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_type = "none"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["groupType"]) == jsonencode("none")
    error_message = "groupType must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    group_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.group_type]
}
