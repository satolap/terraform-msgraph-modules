# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id = "test-parent-id"
    site_id  = "test-parent-id"
    store_id = "test-parent-id"
    set_id   = "test-parent-id"
    term_id  = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/sites/test-parent-id/termStores/test-parent-id/sets/test-parent-id/terms/test-parent-id/children"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["children", "descriptions", "labels", "properties", "relations", "set"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id = "test-parent-id"
    site_id  = "test-parent-id"
    store_id = "test-parent-id"
    set_id   = "test-parent-id"
    term_id  = "test-parent-id"
    children = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["children"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.termStore.term" }])
    error_message = "children must preserve typed values and omit nested nulls."
  }
}
