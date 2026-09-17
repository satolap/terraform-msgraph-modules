# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamTemplateDefinition/test-parent-id/teamDefinition/schedule/swapShiftsChangeRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedTo", "createdBy", "managerActionMessage", "recipientActionMessage", "recipientShiftId", "recipientUserId", "senderMessage", "senderShiftId", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    manager_action_message      = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["managerActionMessage"]) == jsonencode("example")
    error_message = "managerActionMessage must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    assigned_to                 = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.assigned_to]
}
