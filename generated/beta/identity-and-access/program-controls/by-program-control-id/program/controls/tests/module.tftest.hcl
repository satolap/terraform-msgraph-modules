# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    program_control_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "programControls/test-parent-id/program/controls"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["controlId", "controlTypeId", "createdDateTime", "displayName", "owner", "program", "programId", "resource", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    program_control_id = "test-parent-id"
    control_id         = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["controlId"]) == jsonencode("example")
    error_message = "controlId must preserve typed values and omit nested nulls."
  }
}
