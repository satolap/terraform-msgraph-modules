# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/informationProtection/threatAssessmentRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["category", "contentType", "createdBy", "createdDateTime", "expectedAssessment", "requestSource", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id  = "test-parent-id"
    category = "undefined"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["category"]) == jsonencode("undefined")
    error_message = "category must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id  = "test-parent-id"
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
