# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    authentication_strength_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identity/conditionalAccess/authenticationStrengths/policies/test-parent-id/combinationConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appliesToCombinations"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    authentication_strength_policy_id = "test-parent-id"
    applies_to_combinations           = ["password"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliesToCombinations"]) == jsonencode(["password"])
    error_message = "appliesToCombinations must preserve typed values and omit nested nulls."
  }
}
