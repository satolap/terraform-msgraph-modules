# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    learning_provider_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "employeeExperience/learningProviders/test-parent-id/learningContents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalTags", "contentWebUrl", "contributors", "createdDateTime", "description", "duration", "externalId", "format", "isActive", "isPremium", "isSearchable", "languageTag", "lastModifiedDateTime", "level", "numberOfPages", "skillTags", "sourceName", "thumbnailWebUrl", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    learning_provider_id = "test-parent-id"
    content_web_url      = "example"
    is_active            = false
    number_of_pages      = -2147483648
    additional_tags      = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentWebUrl"]) == jsonencode("example")
    error_message = "contentWebUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isActive"]) == jsonencode(false)
    error_message = "isActive must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["numberOfPages"]) == jsonencode(-2147483648)
    error_message = "numberOfPages must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalTags"]) == jsonencode(["example"])
    error_message = "additionalTags must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    learning_provider_id = "test-parent-id"
    level                = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.level]
}
