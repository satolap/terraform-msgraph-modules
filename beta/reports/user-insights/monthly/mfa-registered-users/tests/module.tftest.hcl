# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/userInsights/monthly/mfaRegisteredUsers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["factDate", "count", "mfaType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    fact_date   = "2026-01-01"
    graph_count = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["factDate"]) == jsonencode("2026-01-01")
    error_message = "factDate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["count"]) == jsonencode(0)
    error_message = "count must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    mfa_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.mfa_type]
}
