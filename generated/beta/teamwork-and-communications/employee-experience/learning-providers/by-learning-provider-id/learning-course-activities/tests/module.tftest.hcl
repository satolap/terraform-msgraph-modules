# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    learning_provider_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "employeeExperience/learningProviders/test-parent-id/learningCourseActivities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["completedDateTime", "completionPercentage", "externalcourseActivityId", "learnerUserId", "learningContentId", "learningProviderId", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    learning_provider_id  = "test-parent-id"
    completed_date_time   = "2026-01-01T00:00:00Z"
    completion_percentage = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "completedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completionPercentage"]) == jsonencode(-2147483648)
    error_message = "completionPercentage must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    learning_provider_id = "test-parent-id"
    status               = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
