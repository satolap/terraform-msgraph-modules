# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    service_update_message_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/serviceAnnouncement/messages/test-parent-id/attachments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "contentType", "lastModifiedDateTime", "name", "size"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    service_update_message_id = "test-parent-id"
    content                   = "example"
    size                      = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["size"]) == jsonencode(-2147483648)
    error_message = "size must preserve typed values and omit nested nulls."
  }
}
