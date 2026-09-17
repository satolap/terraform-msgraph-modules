# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "auditLogs/directoryProvisioning"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["action", "activityDateTime", "changeId", "cycleId", "durationInMilliseconds", "initiatedBy", "jobId", "modifiedProperties", "provisioningAction", "provisioningStatusInfo", "provisioningSteps", "servicePrincipal", "sourceIdentity", "sourceSystem", "statusInfo", "targetIdentity", "targetSystem", "tenantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    action                   = "example"
    duration_in_milliseconds = -2147483648
    modified_properties      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["action"]) == jsonencode("example")
    error_message = "action must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["durationInMilliseconds"]) == jsonencode(-2147483648)
    error_message = "durationInMilliseconds must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["modifiedProperties"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.modifiedProperty" }])
    error_message = "modifiedProperties must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    provisioning_action = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.provisioning_action]
}
