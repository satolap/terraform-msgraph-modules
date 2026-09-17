# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_policy_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyDefinitions/test-parent-id/nextVersionDefinition/previousVersionDefinition/presentations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["definition", "label", "lastModifiedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_policy_definition_id = "test-parent-id"
    label                      = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["label"]) == jsonencode("example")
    error_message = "label must preserve typed values and omit nested nulls."
  }
}
