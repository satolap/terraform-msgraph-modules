# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    online_meeting_engagement_conversation_id = "test-parent-id"
    engagement_conversation_message_id        = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "communications/onlineMeetingConversations/test-parent-id/messages/test-parent-id/reactions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["reactionBy", "reactionType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    online_meeting_engagement_conversation_id = "test-parent-id"
    engagement_conversation_message_id        = "test-parent-id"
    reaction_type                             = "like"
    reaction_by                               = { "application" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["reactionType"]) == jsonencode("like")
    error_message = "reactionType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["reactionBy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.engagementIdentitySet" })
    error_message = "reactionBy must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    online_meeting_engagement_conversation_id = "test-parent-id"
    engagement_conversation_message_id        = "test-parent-id"
    reaction_type                             = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.reaction_type]
}
