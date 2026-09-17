# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/roleDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "isBuiltIn", "roleAssignments", "rolePermissions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description      = "example"
    is_built_in      = false
    role_assignments = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isBuiltIn"]) == jsonencode(false)
    error_message = "isBuiltIn must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roleAssignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.roleAssignment" }])
    error_message = "roleAssignments must preserve typed values and omit nested nulls."
  }
}
