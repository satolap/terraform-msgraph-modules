# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    planner_plan_id = "test-parent-id"
    odata_type      = "#microsoft.graph.taskHistoryItem"
  }

  assert {
    condition     = msgraph_resource.this.url == "planner/plans/test-parent-id/historyItems"
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
    planner_plan_id = "test-parent-id"
    odata_type      = "#microsoft.graph.taskHistoryItem"
    entity_id       = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.taskHistoryItem")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["entityId"]) == jsonencode("example")
    error_message = "entityId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    planner_plan_id = "test-parent-id"
    odata_type      = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
