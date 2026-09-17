# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    windows_autopilot_deployment_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsAutopilotDeploymentProfiles/test-parent-id/assignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["source", "sourceId", "target"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    windows_autopilot_deployment_profile_id = "test-parent-id"
    graph_source                            = "direct"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["source"]) == jsonencode("direct")
    error_message = "source must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    windows_autopilot_deployment_profile_id = "test-parent-id"
    graph_source                            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.graph_source]
}
