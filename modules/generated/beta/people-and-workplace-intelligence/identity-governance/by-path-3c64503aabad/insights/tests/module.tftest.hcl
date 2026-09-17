# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_review_instance_id                = "test-parent-id"
    access_review_stage_id                   = "test-parent-id"
    access_review_instance_decision_item_id  = "test-parent-id"
    access_review_instance_decision_item_id1 = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/accessReviews/instances/test-parent-id/stages/test-parent-id/decisions/test-parent-id/instance/decisions/test-parent-id/insights"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["insightCreatedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_review_instance_id                = "test-parent-id"
    access_review_stage_id                   = "test-parent-id"
    access_review_instance_decision_item_id  = "test-parent-id"
    access_review_instance_decision_item_id1 = "test-parent-id"
    insight_created_date_time                = "2026-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["insightCreatedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "insightCreatedDateTime must preserve typed values and omit nested nulls."
  }
}
