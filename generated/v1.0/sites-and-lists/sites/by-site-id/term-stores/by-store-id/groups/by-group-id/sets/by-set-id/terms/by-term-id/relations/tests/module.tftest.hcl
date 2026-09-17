# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id  = "test-parent-id"
    store_id = "test-parent-id"
    group_id = "test-parent-id"
    set_id   = "test-parent-id"
    term_id  = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/termStores/test-parent-id/groups/test-parent-id/sets/test-parent-id/terms/test-parent-id/relations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["fromTerm", "relationship", "set", "toTerm"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    site_id      = "test-parent-id"
    store_id     = "test-parent-id"
    group_id     = "test-parent-id"
    set_id       = "test-parent-id"
    term_id      = "test-parent-id"
    relationship = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.relationship]
}
