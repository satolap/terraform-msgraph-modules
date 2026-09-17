# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teams/test-parent-id/tags"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "memberCount", "members", "tagType", "teamId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_id      = "test-parent-id"
    description  = "example"
    member_count = -2147483648
    members      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["memberCount"]) == jsonencode(-2147483648)
    error_message = "memberCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["members"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.teamworkTagMember" }])
    error_message = "members must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_id  = "test-parent-id"
    tag_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.tag_type]
}
