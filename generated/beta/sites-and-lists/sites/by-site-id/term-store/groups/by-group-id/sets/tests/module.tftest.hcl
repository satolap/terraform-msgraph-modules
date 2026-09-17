# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id  = "test-parent-id"
    group_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/termStore/groups/test-parent-id/sets"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["children", "description", "localizedNames", "parentGroup", "properties", "relations", "terms"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id      = "test-parent-id"
    group_id     = "test-parent-id"
    description  = "example"
    parent_group = { "description" = null }
    children     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["parentGroup"]) == jsonencode({ "@odata.type" = "#microsoft.graph.termStore.group" })
    error_message = "parentGroup must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["children"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.termStore.term" }])
    error_message = "children must preserve typed values and omit nested nulls."
  }
}
