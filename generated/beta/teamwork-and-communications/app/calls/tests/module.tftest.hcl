# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "app/calls"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["audioRoutingGroups", "callChainId", "callOptions", "callbackUri", "chatInfo", "contentSharingSessions", "source", "mediaConfig", "meetingInfo", "myParticipantId", "operations", "participants", "requestedModalities", "ringingTimeoutInSeconds", "routingPolicies", "subject", "targets", "terminationReason", "toneInfo"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    call_chain_id              = "example"
    ringing_timeout_in_seconds = -2147483648
    audio_routing_groups       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["callChainId"]) == jsonencode("example")
    error_message = "callChainId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["ringingTimeoutInSeconds"]) == jsonencode(-2147483648)
    error_message = "ringingTimeoutInSeconds must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["audioRoutingGroups"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.audioRoutingGroup" }])
    error_message = "audioRoutingGroups must preserve typed values and omit nested nulls."
  }
}
