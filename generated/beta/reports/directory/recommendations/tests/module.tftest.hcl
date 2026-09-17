# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "directory/recommendations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionSteps", "benefits", "category", "categoryGroup", "completedBySystemDateTime", "completedByUserDateTime", "createdDateTime", "currentScore", "displayName", "failedReviewDateTime", "featureAreas", "impactStartDateTime", "impactType", "impactedResources", "insights", "lastCheckedDateTime", "lastModifiedBy", "lastModifiedDateTime", "maxScore", "needsMoreActionResourceCount", "nistClassifications", "postponeUntilDateTime", "priority", "recommendationType", "releaseType", "remediatedDateTime", "remediationImpact", "requiredLicenses", "status", "statusModifiedDateTime", "tags"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    benefits                         = "example"
    needs_more_action_resource_count = -2147483648
    action_steps                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["benefits"]) == jsonencode("example")
    error_message = "benefits must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["needsMoreActionResourceCount"]) == jsonencode(-2147483648)
    error_message = "needsMoreActionResourceCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionSteps"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.actionStep" }])
    error_message = "actionSteps must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
