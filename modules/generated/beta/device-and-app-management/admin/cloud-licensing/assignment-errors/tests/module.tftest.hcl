# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/cloudLicensing/assignmentErrors"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedTo", "code", "message", "occurrenceDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    code        = "example"
    assigned_to = { "deletedDateTime" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["code"]) == jsonencode("example")
    error_message = "code must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedTo"]) == jsonencode({ "@odata.type" = "#microsoft.graph.directoryObject" })
    error_message = "assignedTo must preserve typed values and omit nested nulls."
  }
}
