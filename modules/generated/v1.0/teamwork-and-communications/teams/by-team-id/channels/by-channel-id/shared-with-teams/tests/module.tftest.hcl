# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_id    = "test-parent-id"
    channel_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teams/test-parent-id/channels/test-parent-id/sharedWithTeams"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedMembers", "displayName", "isHostTeam", "team", "tenantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_id         = "test-parent-id"
    channel_id      = "test-parent-id"
    display_name    = "example"
    is_host_team    = false
    allowed_members = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isHostTeam"]) == jsonencode(false)
    error_message = "isHostTeam must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedMembers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.conversationMember" }])
    error_message = "allowedMembers must preserve typed values and omit nested nulls."
  }
}
