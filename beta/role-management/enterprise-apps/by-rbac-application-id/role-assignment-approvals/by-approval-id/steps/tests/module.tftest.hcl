# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    rbac_application_id = "test-parent-id"
    approval_id         = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "roleManagement/enterpriseApps/test-parent-id/roleAssignmentApprovals/test-parent-id/steps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["justification", "reviewResult"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    rbac_application_id = "test-parent-id"
    approval_id         = "test-parent-id"
    justification       = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["justification"]) == jsonencode("example")
    error_message = "justification must preserve typed values and omit nested nulls."
  }
}
