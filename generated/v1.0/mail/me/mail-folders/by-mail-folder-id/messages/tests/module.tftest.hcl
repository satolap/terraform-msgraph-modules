# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    mail_folder_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/mailFolders/test-parent-id/messages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["attachments", "bccRecipients", "body", "bodyPreview", "categories", "ccRecipients", "conversationId", "conversationIndex", "createdDateTime", "extensions", "flag", "from", "hasAttachments", "importance", "inferenceClassification", "internetMessageId", "isDeliveryReceiptRequested", "isDraft", "isRead", "isReadReceiptRequested", "lastModifiedDateTime", "multiValueExtendedProperties", "parentFolderId", "receivedDateTime", "replyTo", "sender", "sentDateTime", "singleValueExtendedProperties", "subject", "toRecipients", "uniqueBody", "webLink"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    mail_folder_id  = "test-parent-id"
    body_preview    = "example"
    has_attachments = false
    attachments     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["bodyPreview"]) == jsonencode("example")
    error_message = "bodyPreview must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasAttachments"]) == jsonencode(false)
    error_message = "hasAttachments must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attachments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.attachment" }])
    error_message = "attachments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    mail_folder_id = "test-parent-id"
    importance     = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.importance]
}
