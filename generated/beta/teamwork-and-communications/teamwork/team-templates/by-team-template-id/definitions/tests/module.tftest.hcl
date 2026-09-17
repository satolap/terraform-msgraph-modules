# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamwork/teamTemplates/test-parent-id/definitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["audience", "categories", "description", "displayName", "iconUrl", "languageTag", "lastModifiedBy", "lastModifiedDateTime", "parentTemplateId", "publisherName", "shortDescription", "teamDefinition"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_id = "test-parent-id"
    description      = "example"
    categories       = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categories"]) == jsonencode(["example"])
    error_message = "categories must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_template_id = "test-parent-id"
    audience         = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.audience]
}
