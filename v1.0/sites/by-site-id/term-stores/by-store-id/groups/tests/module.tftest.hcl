# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id  = "test-parent-id"
    store_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/termStores/test-parent-id/groups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "parentSiteId", "scope", "sets"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id     = "test-parent-id"
    store_id    = "test-parent-id"
    description = "example"
    sets        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sets"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.termStore.set" }])
    error_message = "sets must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    site_id  = "test-parent-id"
    store_id = "test-parent-id"
    scope    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.scope]
}
