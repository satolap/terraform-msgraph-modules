# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    channel_id                  = "test-parent-id"
    odata_type                  = "#microsoft.graph.aadUserConversationMember"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamTemplateDefinition/test-parent-id/teamDefinition/channels/test-parent-id/joinedUsers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "roles", "visibleHistoryStartDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    channel_id                  = "test-parent-id"
    odata_type                  = "#microsoft.graph.aadUserConversationMember"
    display_name                = "example"
    roles                       = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.aadUserConversationMember")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roles"]) == jsonencode(["example"])
    error_message = "roles must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    channel_id                  = "test-parent-id"
    odata_type                  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
