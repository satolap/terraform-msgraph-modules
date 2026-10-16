# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    workspace_id = "test-parent-id"
    session_id   = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/securityCopilot/workspaces/test-parent-id/sessions/test-parent-id/prompts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["content", "createdDateTime", "evaluations", "inputs", "lastModifiedDateTime", "skillInputDescriptors", "skillName", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    workspace_id = "test-parent-id"
    session_id   = "test-parent-id"
    content      = "example"
    evaluations  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["content"]) == jsonencode("example")
    error_message = "content must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["evaluations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.securityCopilot.evaluation" }])
    error_message = "evaluations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    workspace_id = "test-parent-id"
    session_id   = "test-parent-id"
    type         = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.type]
}
