# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    call_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "app/calls/test-parent-id/participants"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["info", "isIdentityAnonymized", "isInLobby", "isMuted", "mediaStreams", "metadata", "preferredDisplayName", "recordingInfo", "removedState", "restrictedExperience", "rosterSequenceNumber", "syntheticMediaDetection"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    call_id                = "test-parent-id"
    metadata               = "example"
    is_identity_anonymized = false
    roster_sequence_number = 0
    info                   = { "identity" = null }
    media_streams          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["metadata"]) == jsonencode("example")
    error_message = "metadata must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isIdentityAnonymized"]) == jsonencode(false)
    error_message = "isIdentityAnonymized must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["rosterSequenceNumber"]) == jsonencode(0)
    error_message = "rosterSequenceNumber must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["info"]) == jsonencode({ "@odata.type" = "#microsoft.graph.participantInfo" })
    error_message = "info must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["mediaStreams"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.mediaStream" }])
    error_message = "mediaStreams must preserve typed values and omit nested nulls."
  }
}
