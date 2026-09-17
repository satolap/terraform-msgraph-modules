# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/pageTemplates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["canvasLayout", "createdByUser", "description", "lastModifiedByUser", "name", "pageLayout", "parentReference", "publishingState", "title", "titleArea", "webParts"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id     = "test-parent-id"
    description = "example"
    web_parts   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["webParts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.webPart" }])
    error_message = "webParts must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    site_id     = "test-parent-id"
    page_layout = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.page_layout]
}
