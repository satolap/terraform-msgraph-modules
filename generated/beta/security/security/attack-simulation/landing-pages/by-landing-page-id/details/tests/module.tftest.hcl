# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    landing_page_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/attackSimulation/landingPages/test-parent-id/details"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "isDefaultLangauge", "language"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    landing_page_id     = "test-parent-id"
    content             = "example"
    is_default_langauge = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefaultLangauge"]) == jsonencode(false)
    error_message = "isDefaultLangauge must preserve typed values and omit nested nulls."
  }
}
