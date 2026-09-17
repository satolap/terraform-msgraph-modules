# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id           = "test-parent-id"
    site_id            = "test-parent-id"
    notebook_id        = "test-parent-id"
    onenote_section_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/sites/test-parent-id/onenote/notebooks/test-parent-id/sections/test-parent-id/pages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "createdDateTime", "self", "title", "userTags"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id           = "test-parent-id"
    site_id            = "test-parent-id"
    notebook_id        = "test-parent-id"
    onenote_section_id = "test-parent-id"
    content            = "example"
    user_tags          = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["userTags"]) == jsonencode(["example"])
    error_message = "userTags must preserve typed values and omit nested nulls."
  }
}
