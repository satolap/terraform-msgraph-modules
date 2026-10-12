# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "copilot/admin/policySettings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["policyId", "value"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    policy_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["policyId"]) == jsonencode("example")
    error_message = "policyId must preserve typed values and omit nested nulls."
  }
}
