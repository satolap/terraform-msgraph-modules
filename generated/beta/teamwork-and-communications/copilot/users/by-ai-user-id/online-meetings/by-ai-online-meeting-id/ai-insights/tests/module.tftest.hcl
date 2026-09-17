# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ai_user_id           = "test-parent-id"
    ai_online_meeting_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "copilot/users/test-parent-id/onlineMeetings/test-parent-id/aiInsights"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionItems", "callId", "contentCorrelationId", "createdDateTime", "endDateTime", "meetingNotes", "viewpoint"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ai_user_id           = "test-parent-id"
    ai_online_meeting_id = "test-parent-id"
    call_id              = "example"
    action_items         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["callId"]) == jsonencode("example")
    error_message = "callId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionItems"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.actionItem" }])
    error_message = "actionItems must preserve typed values and omit nested nulls."
  }
}
