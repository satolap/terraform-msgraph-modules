# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "accessReviews"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["businessFlowTemplateId", "createdBy", "decisions", "description", "displayName", "endDateTime", "instances", "myDecisions", "reviewedEntity", "reviewerType", "reviewers", "settings", "startDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    business_flow_template_id = "example"
    decisions                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["businessFlowTemplateId"]) == jsonencode("example")
    error_message = "businessFlowTemplateId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["decisions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.accessReviewDecision" }])
    error_message = "decisions must preserve typed values and omit nested nulls."
  }
}
