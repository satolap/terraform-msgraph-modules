# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "search/bookmarks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["availabilityEndDateTime", "availabilityStartDateTime", "categories", "description", "displayName", "groupIds", "keywords", "languageTags", "platforms", "powerAppIds", "state", "targetedVariations", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    availability_end_date_time = "2026-01-01T00:00:00Z"
    categories                 = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["availabilityEndDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "availabilityEndDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categories"]) == jsonencode(["example"])
    error_message = "categories must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
