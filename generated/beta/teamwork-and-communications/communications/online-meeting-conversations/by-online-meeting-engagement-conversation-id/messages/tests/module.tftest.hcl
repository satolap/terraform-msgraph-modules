# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    online_meeting_engagement_conversation_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "communications/onlineMeetingConversations/test-parent-id/messages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["body", "conversation", "creationMode", "from", "reactions", "replies", "replyTo", "replyToId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    online_meeting_engagement_conversation_id = "test-parent-id"
    creation_mode                             = "none"
    body                                      = { "content" = null }
    reactions                                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["creationMode"]) == jsonencode("none")
    error_message = "creationMode must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["body"]) == jsonencode({ "@odata.type" = "#microsoft.graph.itemBody" })
    error_message = "body must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["reactions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.engagementConversationMessageReaction" }])
    error_message = "reactions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    online_meeting_engagement_conversation_id = "test-parent-id"
    creation_mode                             = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.creation_mode]
}
