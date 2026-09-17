# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    workspace_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/securityCopilot/workspaces/test-parent-id/sessions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "displayName", "lastModifiedDateTime", "prompts"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    workspace_id      = "test-parent-id"
    created_date_time = "2026-01-01T00:00:00Z"
    prompts           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["prompts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.securityCopilot.prompt" }])
    error_message = "prompts must preserve typed values and omit nested nulls."
  }
}
