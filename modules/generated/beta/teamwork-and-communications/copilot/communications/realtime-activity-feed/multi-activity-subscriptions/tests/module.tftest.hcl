# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "copilot/communications/realtimeActivityFeed/multiActivitySubscriptions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activities", "callbackUrl", "chatInfo", "meetingInfo", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    callback_url = "example"
    activities   = { "transcript" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["callbackUrl"]) == jsonencode("example")
    error_message = "callbackUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activities"]) == jsonencode({ "@odata.type" = "#microsoft.graph.subscriptionActivities" })
    error_message = "activities must preserve typed values and omit nested nulls."
  }
}
