mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] }, result = {} } }
  }
  mock_data "msgraph_resource" {
    defaults = { output = { usage = { mfa = [], none = [] }, collection = { value = [] }, policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] } } }
  }
}

variables {
  detached_maintenance = true
  displayName          = "Configuration identity"
  allowedCombinations  = ["fido2"]
}
run "refuses_empty_matching_ids" {
  command = apply
  variables {
    allowedAAGUIDs = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { "id" : "", "output" : { "configuration" : { "id" : "", "@odata.type" : "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" : ["fido2"], "allowedAAGUIDs" : ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] } } }
  }
  expect_failures = [msgraph_resource.configuration["fido2"]]
}
run "refuses_malformed_matching_ids" {
  command = apply
  variables {
    allowedAAGUIDs = ["bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"]
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { "id" : "not-a-guid", "output" : { "configuration" : { "id" : "not-a-guid", "@odata.type" : "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" : ["fido2"], "allowedAAGUIDs" : ["bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"] } } }
  }
  expect_failures = [msgraph_resource.configuration["fido2"]]
}
run "accepts_well_formed_matching_ids" {
  command = apply
  variables {
    allowedAAGUIDs = ["cccccccc-cccc-cccc-cccc-cccccccccccc"]
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { "id" : "33333333-3333-3333-3333-333333333333", "output" : { "configuration" : { "id" : "33333333-3333-3333-3333-333333333333", "@odata.type" : "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" : ["fido2"], "allowedAAGUIDs" : ["cccccccc-cccc-cccc-cccc-cccccccccccc"] } } }
  }
  assert {
    condition     = output.combinationConfigurationIds["fido2"] == "33333333-3333-3333-3333-333333333333"
    error_message = "A well-formed, matching created ID must be accepted."
  }
}
