# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/virtualEndpoint/auditEvents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activity", "activityOperationType", "activityResult", "actor", "category"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activity = "example"
    actor    = { "applicationDisplayName" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activity"]) == jsonencode("example")
    error_message = "activity must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actor"]) == jsonencode({ "@odata.type" = "#microsoft.graph.cloudPcAuditActor" })
    error_message = "actor must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    activity_operation_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.activity_operation_type]
}
