# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identity/conditionalAccess/policies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["conditions", "deletedDateTime", "description", "displayName", "grantControls", "sessionControls", "state", "templateId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    deleted_date_time = "2026-01-01T00:00:00Z"
    conditions        = { "applications" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deletedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "deletedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["conditions"]) == jsonencode({ "@odata.type" = "#microsoft.graph.conditionalAccessConditionSet" })
    error_message = "conditions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
