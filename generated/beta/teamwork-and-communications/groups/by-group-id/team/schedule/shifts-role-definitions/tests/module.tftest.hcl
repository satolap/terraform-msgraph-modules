# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/team/schedule/shiftsRoleDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "shiftsRolePermissions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id                = "test-parent-id"
    description             = "example"
    shifts_role_permissions = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["shiftsRolePermissions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.shiftsRolePermission" }])
    error_message = "shiftsRolePermissions must preserve typed values and omit nested nulls."
  }
}
