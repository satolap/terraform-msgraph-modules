# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "solutions/backupRestore/activityLogs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activityType", "error", "eventDateTime", "performedBy", "resultStatus", "serviceType", "severity"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activity_type = "backupPolicyCreated"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityType"]) == jsonencode("backupPolicyCreated")
    error_message = "activityType must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    activity_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.activity_type]
}
