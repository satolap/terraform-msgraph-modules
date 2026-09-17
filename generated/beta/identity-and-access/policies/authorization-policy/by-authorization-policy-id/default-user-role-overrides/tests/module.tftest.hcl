# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    authorization_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "policies/authorizationPolicy/test-parent-id/defaultUserRoleOverrides"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["isDefault", "rolePermissions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    authorization_policy_id = "test-parent-id"
    is_default              = false
    role_permissions        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefault"]) == jsonencode(false)
    error_message = "isDefault must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["rolePermissions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.unifiedRolePermission" }])
    error_message = "rolePermissions must preserve typed values and omit nested nulls."
  }
}
