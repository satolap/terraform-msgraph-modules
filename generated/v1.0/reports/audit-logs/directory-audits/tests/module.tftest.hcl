# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "auditLogs/directoryAudits"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activityDateTime", "activityDisplayName", "additionalDetails", "category", "correlationId", "initiatedBy", "loggedByService", "operationType", "result", "resultReason", "targetResources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activity_date_time = "2026-01-01T00:00:00Z"
    initiated_by       = { "app" = null }
    additional_details = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "activityDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["initiatedBy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.auditActivityInitiator" })
    error_message = "initiatedBy must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalDetails"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.keyValue" }])
    error_message = "additionalDetails must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    result = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.result]
}
