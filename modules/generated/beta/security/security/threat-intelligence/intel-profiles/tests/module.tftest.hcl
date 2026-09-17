# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatIntelligence/intelProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["aliases", "countriesOrRegionsOfOrigin", "description", "firstActiveDateTime", "indicators", "kind", "summary", "targets", "title", "tradecraft"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    first_active_date_time = "2026-01-01T00:00:00Z"
    description            = { "content" = null }
    aliases                = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["firstActiveDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "firstActiveDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode({ "@odata.type" = "#microsoft.graph.security.formattedContent" })
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["aliases"]) == jsonencode(["example"])
    error_message = "aliases must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    kind = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.kind]
}
