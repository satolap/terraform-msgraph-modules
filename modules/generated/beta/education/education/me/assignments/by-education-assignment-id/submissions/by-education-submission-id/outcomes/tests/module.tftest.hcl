# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "education/me/assignments/test-parent-id/submissions/test-parent-id/outcomes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["lastModifiedBy", "lastModifiedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    last_modified_date_time = "2026-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["lastModifiedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "lastModifiedDateTime must preserve typed values and omit nested nulls."
  }
}
