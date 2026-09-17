# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id         = "test-parent-id"
    channel_id       = "test-parent-id"
    chat_message_id  = "test-parent-id"
    chat_message_id1 = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/team/channels/test-parent-id/messages/test-parent-id/replies/test-parent-id/hostedContents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["contentBytes", "contentType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id         = "test-parent-id"
    channel_id       = "test-parent-id"
    chat_message_id  = "test-parent-id"
    chat_message_id1 = "test-parent-id"
    content_bytes    = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentBytes"]) == jsonencode("example")
    error_message = "contentBytes must preserve typed values and omit nested nulls."
  }
}
