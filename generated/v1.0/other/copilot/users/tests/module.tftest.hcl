# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "copilot/users"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["interactionHistory", "onlineMeetings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    online_meetings = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["onlineMeetings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.aiOnlineMeeting" }])
    error_message = "onlineMeetings must preserve typed values and omit nested nulls."
  }
}
