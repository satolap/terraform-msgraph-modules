# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    recommendation_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "directory/recommendations/test-parent-id/impactedResources"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["addedDateTime", "additionalDetails", "apiUrl", "displayName", "lastModifiedBy", "lastModifiedDateTime", "owner", "portalUrl", "postponeUntilDateTime", "rank", "recommendationId", "resourceType", "status", "subjectId", "tags"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    recommendation_id  = "test-parent-id"
    added_date_time    = "2026-01-01T00:00:00Z"
    rank               = -2147483648
    additional_details = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["addedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "addedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["rank"]) == jsonencode(-2147483648)
    error_message = "rank must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalDetails"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.keyValue" }])
    error_message = "additionalDetails must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    recommendation_id = "test-parent-id"
    status            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
