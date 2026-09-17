# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    site_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "sites/test-parent-id/documentProcessingJobs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["jobType", "listItemUniqueId", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    site_id             = "test-parent-id"
    list_item_unique_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["listItemUniqueId"]) == jsonencode("example")
    error_message = "listItemUniqueId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    site_id  = "test-parent-id"
    job_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.job_type]
}
