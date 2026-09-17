# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/complianceCategories"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["categoryDescription", "childCategoryIds", "description", "displayName", "helpText", "name", "parentCategoryId", "platforms", "rootCategoryId", "settingUsage", "technologies"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    category_description = "example"
    child_category_ids   = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categoryDescription"]) == jsonencode("example")
    error_message = "categoryDescription must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["childCategoryIds"]) == jsonencode(["example"])
    error_message = "childCategoryIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    platforms = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platforms]
}
