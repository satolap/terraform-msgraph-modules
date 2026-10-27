mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] }, result = {} } }
  }
  mock_data "msgraph_resource" {
    defaults = { output = { usage = { mfa = [], none = [] }, collection = { value = [] }, policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] } } }
  }
}

variables {
  displayName         = "Custom strength"
  allowedCombinations = ["fido2"]
}

run "refuses_builtin_create_response" {
  command = apply
  override_resource {
    target = msgraph_resource_action.policy
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "builtIn" } } }
  }
  expect_failures = [msgraph_resource_action.policy]
}

