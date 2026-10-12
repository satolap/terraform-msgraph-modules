# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/incidentTasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionStatus", "actionType", "description", "displayName", "source", "incident", "responseAction", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    action_status = "notStarted"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionStatus"]) == jsonencode("notStarted")
    error_message = "actionStatus must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    action_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.action_status]
}
