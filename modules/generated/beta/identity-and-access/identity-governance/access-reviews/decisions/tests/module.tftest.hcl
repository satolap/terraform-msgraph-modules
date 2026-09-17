# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/accessReviews/decisions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applyDescription", "decision", "insights", "instance", "justification", "permission"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    apply_description = "example"
    insights          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applyDescription"]) == jsonencode("example")
    error_message = "applyDescription must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["insights"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.governanceInsight" }])
    error_message = "insights must preserve typed values and omit nested nulls."
  }
}
