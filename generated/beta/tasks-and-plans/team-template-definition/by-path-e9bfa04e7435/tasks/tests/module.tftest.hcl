# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    planner_plan_id             = "test-parent-id"
    planner_bucket_id           = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamTemplateDefinition/test-parent-id/teamDefinition/primaryChannel/planner/plans/test-parent-id/buckets/test-parent-id/tasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activeChecklistItemCount", "appliedCategories", "assigneePriority", "assignments", "bucketId", "checklistItemCount", "completedBy", "conversationThreadId", "createdBy", "creationSource", "dueDateTime", "isOnMyDay", "orderHint", "percentComplete", "planId", "previewType", "priority", "recurrence", "referenceCount", "startDateTime", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    planner_plan_id             = "test-parent-id"
    planner_bucket_id           = "test-parent-id"
    assignee_priority           = "example"
    is_on_my_day                = false
    active_checklist_item_count = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assigneePriority"]) == jsonencode("example")
    error_message = "assigneePriority must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isOnMyDay"]) == jsonencode(false)
    error_message = "isOnMyDay must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activeChecklistItemCount"]) == jsonencode(-2147483648)
    error_message = "activeChecklistItemCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    planner_plan_id             = "test-parent-id"
    planner_bucket_id           = "test-parent-id"
    preview_type                = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.preview_type]
}
