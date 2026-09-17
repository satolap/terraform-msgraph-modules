# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id        = "test-parent-id"
    planner_plan_id = "test-parent-id"
    planner_task_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/team/primaryChannel/planner/plans/test-parent-id/tasks/test-parent-id/messages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "createdBy", "createdDateTime", "deletedDateTime", "editedDateTime", "mentions", "messageType", "parentEntityId", "reactions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id        = "test-parent-id"
    planner_plan_id = "test-parent-id"
    planner_task_id = "test-parent-id"
    content         = "example"
    mentions        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["mentions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.plannerTaskChatMention" }])
    error_message = "mentions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    group_id        = "test-parent-id"
    planner_plan_id = "test-parent-id"
    planner_task_id = "test-parent-id"
    message_type    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.message_type]
}
