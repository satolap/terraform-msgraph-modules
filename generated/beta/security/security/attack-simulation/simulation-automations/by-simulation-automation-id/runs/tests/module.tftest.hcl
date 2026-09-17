# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    simulation_automation_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/attackSimulation/simulationAutomations/test-parent-id/runs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["endDateTime", "simulationId", "startDateTime", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    simulation_automation_id = "test-parent-id"
    end_date_time            = "2026-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["endDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "endDateTime must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    simulation_automation_id = "test-parent-id"
    status                   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
