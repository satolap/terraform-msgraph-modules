# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    chat_message_id             = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamTemplateDefinition/test-parent-id/teamDefinition/primaryChannel/messages/test-parent-id/replies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["attachments", "body", "channelIdentity", "chatId", "createdDateTime", "from", "hasReplies", "hostedContents", "importance", "locale", "mentions", "messageHistory", "messageType", "onBehalfOf", "policyViolation", "reactions", "replies", "subject", "summary"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    chat_message_id             = "test-parent-id"
    chat_id                     = "example"
    has_replies                 = false
    body                        = { "content" = null }
    attachments                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["chatId"]) == jsonencode("example")
    error_message = "chatId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasReplies"]) == jsonencode(false)
    error_message = "hasReplies must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["body"]) == jsonencode({ "@odata.type" = "#microsoft.graph.chatMessageBody" })
    error_message = "body must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attachments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.chatMessageAttachment" }])
    error_message = "attachments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    chat_message_id             = "test-parent-id"
    importance                  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.importance]
}
