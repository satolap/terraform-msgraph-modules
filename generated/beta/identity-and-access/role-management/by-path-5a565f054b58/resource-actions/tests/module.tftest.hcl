# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    unified_rbac_resource_namespace_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "roleManagement/entitlementManagement/resourceNamespaces/test-parent-id/resourceActions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionVerb", "authenticationContext", "authenticationContextId", "description", "isAuthenticationContextSettable", "name", "resourceScope", "resourceScopeId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    unified_rbac_resource_namespace_id = "test-parent-id"
    action_verb                        = "example"
    is_authentication_context_settable = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionVerb"]) == jsonencode("example")
    error_message = "actionVerb must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAuthenticationContextSettable"]) == jsonencode(false)
    error_message = "isAuthenticationContextSettable must preserve typed values and omit nested nulls."
  }
}
