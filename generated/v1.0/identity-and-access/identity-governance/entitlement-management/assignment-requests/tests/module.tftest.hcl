# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/assignmentRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["answers", "assignment", "customExtensionCalloutInstances", "justification", "parameters", "requestType", "schedule"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    justification = "example"
    answers       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["justification"]) == jsonencode("example")
    error_message = "justification must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["answers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.accessPackageAnswer" }])
    error_message = "answers must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    request_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.request_type]
}
