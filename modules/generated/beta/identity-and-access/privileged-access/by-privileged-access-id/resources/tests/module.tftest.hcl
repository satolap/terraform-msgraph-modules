# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    privileged_access_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "privilegedAccess/test-parent-id/resources"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "externalId", "registeredDateTime", "registeredRoot", "roleAssignmentRequests", "roleAssignments", "roleDefinitions", "roleSettings", "status", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    privileged_access_id     = "test-parent-id"
    display_name             = "example"
    role_assignment_requests = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roleAssignmentRequests"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.governanceRoleAssignmentRequest" }])
    error_message = "roleAssignmentRequests must preserve typed values and omit nested nulls."
  }
}
