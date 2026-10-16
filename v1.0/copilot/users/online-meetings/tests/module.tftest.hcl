# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ai_user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "copilot/users/test-parent-id/onlineMeetings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["aiInsights"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ai_user_id  = "test-parent-id"
    ai_insights = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["aiInsights"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.callAiInsight" }])
    error_message = "aiInsights must preserve typed values and omit nested nulls."
  }
}
