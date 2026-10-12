# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.backupPolicyActivityLog"
  }

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
    odata_type    = "#microsoft.graph.backupPolicyActivityLog"
    activity_type = "backupPolicyCreated"
    error         = { "code" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.backupPolicyActivityLog")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityType"]) == jsonencode("backupPolicyCreated")
    error_message = "activityType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["error"]) == jsonencode({ "@odata.type" = "#microsoft.graph.publicError" })
    error_message = "error must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
