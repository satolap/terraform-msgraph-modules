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

run "creates_policy_for_refresh_tests" {
  command = apply
}

run "refuses_builtin_independent_read" {
  command = plan
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "builtIn" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_mismatched_identity" {
  command = plan
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { policy = { id = "22222222-2222-2222-2222-222222222222", policyType = "custom", allowedCombinations = ["fido2"] } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_missing_ownership" {
  command = plan
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { policy = {} } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

