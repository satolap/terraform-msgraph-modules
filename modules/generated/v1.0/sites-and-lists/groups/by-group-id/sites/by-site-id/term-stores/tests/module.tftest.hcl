# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id = "test-parent-id"
    site_id  = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/sites/test-parent-id/termStores"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["defaultLanguageTag", "groups", "languageTags", "sets"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id             = "test-parent-id"
    site_id              = "test-parent-id"
    default_language_tag = "example"
    groups               = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultLanguageTag"]) == jsonencode("example")
    error_message = "defaultLanguageTag must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["groups"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.termStore.group" }])
    error_message = "groups must preserve typed values and omit nested nulls."
  }
}
