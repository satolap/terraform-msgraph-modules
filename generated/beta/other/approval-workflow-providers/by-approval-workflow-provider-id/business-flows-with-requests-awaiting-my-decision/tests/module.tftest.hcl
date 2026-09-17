# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    approval_workflow_provider_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "approvalWorkflowProviders/test-parent-id/businessFlowsWithRequestsAwaitingMyDecision"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["customData", "deDuplicationId", "description", "displayName", "policy", "policyTemplateId", "recordVersion", "schemaId", "settings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    approval_workflow_provider_id = "test-parent-id"
    custom_data                   = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customData"]) == jsonencode("example")
    error_message = "customData must preserve typed values and omit nested nulls."
  }
}
