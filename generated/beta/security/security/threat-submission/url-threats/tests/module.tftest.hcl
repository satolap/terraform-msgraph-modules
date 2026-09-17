# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatSubmission/urlThreats"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["adminReview", "category", "clientSource", "contentType", "createdBy", "createdDateTime", "source", "result", "status", "tenantId", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    category = "notJunk"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["category"]) == jsonencode("notJunk")
    error_message = "category must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
