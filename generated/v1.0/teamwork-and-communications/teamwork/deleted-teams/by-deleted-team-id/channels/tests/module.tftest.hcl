# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    deleted_team_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamwork/deletedTeams/test-parent-id/channels"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allMembers", "description", "displayName", "enabledApps", "filesFolder", "isFavoriteByDefault", "layoutType", "members", "membershipType", "messages", "migrationMode", "originalCreatedDateTime", "sharedWithTeams", "summary", "tabs", "tenantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    deleted_team_id        = "test-parent-id"
    description            = "example"
    is_favorite_by_default = false
    all_members            = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isFavoriteByDefault"]) == jsonencode(false)
    error_message = "isFavoriteByDefault must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allMembers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.conversationMember" }])
    error_message = "allMembers must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    deleted_team_id = "test-parent-id"
    layout_type     = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.layout_type]
}
