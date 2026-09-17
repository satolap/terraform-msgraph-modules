# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_id            = "test-parent-id"
    team_template_definition_id = "test-parent-id"
    channel_id                  = "test-parent-id"
    planner_plan_id             = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamwork/teamTemplates/test-parent-id/definitions/test-parent-id/teamDefinition/channels/test-parent-id/planner/plans/test-parent-id/historyItems"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actor", "entityId", "entityType", "eventType", "occurredDateTime", "planId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_id            = "test-parent-id"
    team_template_definition_id = "test-parent-id"
    channel_id                  = "test-parent-id"
    planner_plan_id             = "test-parent-id"
    entity_id                   = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["entityId"]) == jsonencode("example")
    error_message = "entityId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_template_id            = "test-parent-id"
    team_template_definition_id = "test-parent-id"
    channel_id                  = "test-parent-id"
    planner_plan_id             = "test-parent-id"
    entity_type                 = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.entity_type]
}
