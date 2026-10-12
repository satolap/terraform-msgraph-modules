# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    realtime_activity_meeting_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "copilot/communications/realtimeActivityFeed/meetings/test-parent-id/transcripts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["payloads"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    realtime_activity_meeting_id = "test-parent-id"
    payloads                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["payloads"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.transcriptPayload" }])
    error_message = "payloads must preserve typed values and omit nested nulls."
  }
}
