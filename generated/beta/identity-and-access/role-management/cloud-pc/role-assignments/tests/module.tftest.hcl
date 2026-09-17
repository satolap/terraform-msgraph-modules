# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "roleManagement/cloudPC/roleAssignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appScopeIds", "condition", "description", "directoryScopeIds", "displayName", "principalIds", "roleDefinition", "roleDefinitionId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    condition     = "example"
    app_scope_ids = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["condition"]) == jsonencode("example")
    error_message = "condition must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appScopeIds"]) == jsonencode(["example"])
    error_message = "appScopeIds must preserve typed values and omit nested nulls."
  }
}
