# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    call_record_id = "test-parent-id"
    session_id     = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "communications/callRecords/test-parent-id/sessions/test-parent-id/segments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["callee", "caller", "endDateTime", "failureInfo", "media", "startDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    call_record_id = "test-parent-id"
    session_id     = "test-parent-id"
    end_date_time  = "2026-01-01T00:00:00Z"
    media          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["endDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "endDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["media"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.callRecords.media" }])
    error_message = "media must preserve typed values and omit nested nulls."
  }
}
