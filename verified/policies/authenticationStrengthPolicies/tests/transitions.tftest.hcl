mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      output = {
        policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["password"] }
        result = { currentCombinations = ["password"] }
      }
    }
  }
  mock_data "msgraph_resource" {
    defaults = {
      output = { usage = { mfa = [], none = [] }, collection = { value = [] }, policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["password"] } }
    }
  }
  mock_resource "msgraph_resource" {
    defaults = { id = "22222222-2222-2222-2222-222222222222" }
  }
}

variables {
  detached_maintenance = true
  displayName          = "Transition guard"
  allowedCombinations  = ["password"]
}

run "creates_unreferenced_policy" {
  command = apply
}

run "refuses_adding_restricted_fido2" {
  command = plan
  variables {
    allowedCombinations = ["fido2"]
    allowedAAGUIDs      = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_restricting_existing_method_fido2" {
  command = plan
  variables {
    allowedCombinations = ["fido2"]
    allowedAAGUIDs      = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_adding_restricted_x509CertificateSingleFactor" {
  command = plan
  variables {
    allowedCombinations                      = ["x509CertificateSingleFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateSingleFactor" = { "allowedIssuerSkis" = ["AABBCC"] } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [{ "id" = "44444444-4444-4444-4444-444444444444" }] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_restricting_existing_method_x509CertificateSingleFactor" {
  command = plan
  variables {
    allowedCombinations                      = ["x509CertificateSingleFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateSingleFactor" = { "allowedIssuerSkis" = ["AABBCC"] } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [{ "id" = "44444444-4444-4444-4444-444444444444" }] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateSingleFactor"] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_adding_restricted_x509CertificateMultiFactor" {
  command = plan
  variables {
    allowedCombinations                      = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateMultiFactor" = { "allowedPolicyOIDs" = ["1.2.3.4"] } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_restricting_existing_method_x509CertificateMultiFactor" {
  command = plan
  variables {
    allowedCombinations                      = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateMultiFactor" = { "allowedPolicyOIDs" = ["1.2.3.4"] } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateMultiFactor"] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_missing_none" {
  command = plan
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_null_none" {
  command = plan
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = null } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_object_mfa" {
  command = plan
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = {}, "none" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_paged_mfa" {
  command = plan
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [], "mfa@odata.nextLink" = "unread-page" } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_missing_usage_payload" {
  command = plan
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = {} }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_paged_configurations" {
  command = plan
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [], "@odata.nextLink" = "unread-page" } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_missing_configurations" {
  command = plan
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = {} } }
  }
  expect_failures = [terraform_data.transition]
}

run "creates_detached_fido2" {
  command = apply
  variables {
    allowedCombinations = ["fido2"]
    allowedAAGUIDs      = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_data {
    target = data.msgraph_resource.current
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["fido2"] } } }
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { "id" = "22222222-2222-2222-2222-222222222222", "output" = { "configuration" = { "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" = ["fido2"], "allowedAAGUIDs" = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] } } }
  }
}

run "allows_referenced_noop_fido2" {
  command = plan
  variables {
    detached_maintenance = false
    allowedCombinations  = ["fido2"]
    allowedAAGUIDs       = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" = ["fido2"], "allowedAAGUIDs" = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
}

run "allows_referenced_metadata_fido2" {
  command = plan
  variables {
    detached_maintenance = false
    displayName          = "Metadata only"
    allowedCombinations  = ["fido2"]
    allowedAAGUIDs       = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" = ["fido2"], "allowedAAGUIDs" = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
}

run "refuses_replacing_referenced_fido2" {
  command = plan
  variables {
    allowedCombinations = ["fido2"]
    allowedAAGUIDs      = ["bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"]
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" = ["fido2"], "allowedAAGUIDs" = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_removing_referenced_fido2" {
  command = plan
  variables {
    allowedCombinations = ["fido2"]
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" = ["fido2"], "allowedAAGUIDs" = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "referenced_restrictions_survive_refusals_fido2" {
  command = apply
  variables {
    detached_maintenance = false
    allowedCombinations  = ["fido2"]
    allowedAAGUIDs       = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" = ["fido2"], "allowedAAGUIDs" = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  assert {
    condition     = output.combinationConfigurationIds["fido2"] == "22222222-2222-2222-2222-222222222222"
    error_message = "Refused transitions must leave the original restricted configuration intact."
  }
}

run "removes_detached_fido2" {
  command = apply
  variables {
    allowedCombinations = ["password"]
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["fido2"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", "appliesToCombinations" = ["fido2"], "allowedAAGUIDs" = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] }] } } }
  }
  assert {
    condition     = length(output.combinationConfigurationIds) == 0
    error_message = "Detaching references permits removal; no referencing policy may observe this gap."
  }
}

run "creates_detached_x509CertificateSingleFactor" {
  command = apply
  variables {
    allowedCombinations                      = ["x509CertificateSingleFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateSingleFactor" = { "allowedIssuerSkis" = ["AABBCC"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateSingleFactor"] } } }
  }
  override_resource {
    target = msgraph_resource.configuration["x509CertificateSingleFactor"]
    values = { "id" = "22222222-2222-2222-2222-222222222222", "output" = { "configuration" = { "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateSingleFactor"], "allowedIssuerSkis" = ["AABBCC"] } } }
  }
}

run "allows_referenced_noop_x509CertificateSingleFactor" {
  command = plan
  variables {
    detached_maintenance                     = false
    allowedCombinations                      = ["x509CertificateSingleFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateSingleFactor" = { "allowedIssuerSkis" = ["AABBCC"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateSingleFactor"], "allowedIssuerSkis" = ["AABBCC"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [{ "id" = "44444444-4444-4444-4444-444444444444" }] } } }
  }
}

run "allows_referenced_metadata_x509CertificateSingleFactor" {
  command = plan
  variables {
    detached_maintenance                     = false
    displayName                              = "Metadata only"
    allowedCombinations                      = ["x509CertificateSingleFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateSingleFactor" = { "allowedIssuerSkis" = ["AABBCC"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateSingleFactor"], "allowedIssuerSkis" = ["AABBCC"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [{ "id" = "44444444-4444-4444-4444-444444444444" }] } } }
  }
}

run "refuses_replacing_referenced_x509CertificateSingleFactor" {
  command = plan
  variables {
    allowedCombinations                      = ["x509CertificateSingleFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateSingleFactor" = { "allowedIssuerSkis" = ["DDEEFF"] } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateSingleFactor"], "allowedIssuerSkis" = ["AABBCC"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [{ "id" = "44444444-4444-4444-4444-444444444444" }] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_removing_referenced_x509CertificateSingleFactor" {
  command = plan
  variables {
    allowedCombinations = ["x509CertificateSingleFactor"]
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateSingleFactor"], "allowedIssuerSkis" = ["AABBCC"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [{ "id" = "44444444-4444-4444-4444-444444444444" }] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "referenced_restrictions_survive_refusals_x509CertificateSingleFactor" {
  command = apply
  variables {
    detached_maintenance                     = false
    allowedCombinations                      = ["x509CertificateSingleFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateSingleFactor" = { "allowedIssuerSkis" = ["AABBCC"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateSingleFactor"], "allowedIssuerSkis" = ["AABBCC"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [], "none" = [{ "id" = "44444444-4444-4444-4444-444444444444" }] } } }
  }
  assert {
    condition     = output.combinationConfigurationIds["x509CertificateSingleFactor"] == "22222222-2222-2222-2222-222222222222"
    error_message = "Refused transitions must leave the original restricted configuration intact."
  }
}

run "removes_detached_x509CertificateSingleFactor" {
  command = apply
  variables {
    allowedCombinations = ["password"]
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateSingleFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateSingleFactor"], "allowedIssuerSkis" = ["AABBCC"] }] } } }
  }
  assert {
    condition     = length(output.combinationConfigurationIds) == 0
    error_message = "Detaching references permits removal; no referencing policy may observe this gap."
  }
}

run "creates_detached_x509CertificateMultiFactor" {
  command = apply
  variables {
    allowedCombinations                      = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateMultiFactor" = { "allowedPolicyOIDs" = ["1.2.3.4"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateMultiFactor"] } } }
  }
  override_resource {
    target = msgraph_resource.configuration["x509CertificateMultiFactor"]
    values = { "id" = "22222222-2222-2222-2222-222222222222", "output" = { "configuration" = { "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateMultiFactor"], "allowedPolicyOIDs" = ["1.2.3.4"] } } }
  }
}

run "allows_referenced_noop_x509CertificateMultiFactor" {
  command = plan
  variables {
    detached_maintenance                     = false
    allowedCombinations                      = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateMultiFactor" = { "allowedPolicyOIDs" = ["1.2.3.4"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateMultiFactor"], "allowedPolicyOIDs" = ["1.2.3.4"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
}

run "allows_referenced_metadata_x509CertificateMultiFactor" {
  command = plan
  variables {
    detached_maintenance                     = false
    displayName                              = "Metadata only"
    allowedCombinations                      = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateMultiFactor" = { "allowedPolicyOIDs" = ["1.2.3.4"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateMultiFactor"], "allowedPolicyOIDs" = ["1.2.3.4"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
}

run "refuses_replacing_referenced_x509CertificateMultiFactor" {
  command = plan
  variables {
    allowedCombinations                      = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateMultiFactor" = { "allowedPolicyOIDs" = ["1.2.3.5"] } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateMultiFactor"], "allowedPolicyOIDs" = ["1.2.3.4"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "refuses_removing_referenced_x509CertificateMultiFactor" {
  command = plan
  variables {
    allowedCombinations = ["x509CertificateMultiFactor"]
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateMultiFactor"], "allowedPolicyOIDs" = ["1.2.3.4"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  expect_failures = [terraform_data.transition]
}

run "referenced_restrictions_survive_refusals_x509CertificateMultiFactor" {
  command = apply
  variables {
    detached_maintenance                     = false
    allowedCombinations                      = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = { "x509CertificateMultiFactor" = { "allowedPolicyOIDs" = ["1.2.3.4"] } }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateMultiFactor"], "allowedPolicyOIDs" = ["1.2.3.4"] }] } } }
  }
  override_data {
    target = data.msgraph_resource.usage
    values = { "output" = { "usage" = { "mfa" = [{ "id" = "33333333-3333-3333-3333-333333333333" }], "none" = [] } } }
  }
  assert {
    condition     = output.combinationConfigurationIds["x509CertificateMultiFactor"] == "22222222-2222-2222-2222-222222222222"
    error_message = "Refused transitions must leave the original restricted configuration intact."
  }
}

run "removes_detached_x509CertificateMultiFactor" {
  command = apply
  variables {
    allowedCombinations = ["password"]
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { "output" = { "policy" = { "id" = "11111111-1111-1111-1111-111111111111", "policyType" = "custom", "allowedCombinations" = ["x509CertificateMultiFactor"] } } }
  }
  override_data {
    target = data.msgraph_resource.configurations
    values = { "output" = { "collection" = { "value" = [{ "id" = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", "appliesToCombinations" = ["x509CertificateMultiFactor"], "allowedPolicyOIDs" = ["1.2.3.4"] }] } } }
  }
  assert {
    condition     = length(output.combinationConfigurationIds) == 0
    error_message = "Detaching references permits removal; no referencing policy may observe this gap."
  }
}
