# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/legalHolds"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["contentQuery", "createdBy", "createdDateTime", "description", "displayName", "errors", "isEnabled", "lastModifiedBy", "lastModifiedDateTime", "siteSources", "status", "userSources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    content_query      = "example"
    is_enabled         = false
    errors             = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentQuery"]) == jsonencode("example")
    error_message = "contentQuery must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["errors"]) == jsonencode(["example"])
    error_message = "errors must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    status             = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
