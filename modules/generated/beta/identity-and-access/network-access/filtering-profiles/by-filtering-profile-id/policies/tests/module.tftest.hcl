# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    filtering_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/filteringProfiles/test-parent-id/policies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["version", "policy", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    filtering_profile_id = "test-parent-id"
    graph_version        = "example"
    policy               = { "description" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode("example")
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["policy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.networkaccess.policy" })
    error_message = "policy must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    filtering_profile_id = "test-parent-id"
    state                = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
