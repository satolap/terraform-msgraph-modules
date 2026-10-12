# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "teamwork/messaging/customEmojis"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["contentBytes", "createdBy", "createdDateTime", "displayName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    content_bytes = "example"
    created_by    = { "application" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentBytes"]) == jsonencode("example")
    error_message = "contentBytes must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdBy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.customEmojiFromIdentitySet" })
    error_message = "createdBy must preserve typed values and omit nested nulls."
  }
}
