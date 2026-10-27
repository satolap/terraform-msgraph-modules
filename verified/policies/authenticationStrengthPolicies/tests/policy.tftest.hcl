mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      output = {
        policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] }
        result = { currentCombinations = ["fido2"] }
      }
    }
  }
  mock_data "msgraph_resource" {
    defaults = {
      output = { usage = { mfa = [], none = [] }, collection = { value = [] }, policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2"] } }
    }
  }
  mock_resource "msgraph_resource" {
    defaults = { id = "22222222-2222-2222-2222-222222222222" }
  }
}

variables {
  detached_maintenance = true
  displayName          = "Restricted passkeys"
  allowedCombinations  = ["fido2"]
}

run "creates_custom_policy_and_registers_exact_delete" {
  command = apply

  assert {
    condition     = jsonencode(msgraph_resource_action.policy.body) == jsonencode({ displayName = "Restricted passkeys", allowedCombinations = ["fido2"] })
    error_message = "Create only documented custom policy properties."
  }
  assert {
    condition     = msgraph_resource_action.remove.resource_url == "policies/authenticationStrengthPolicies/11111111-1111-1111-1111-111111111111"
    error_message = "Destroy must target exactly the independently verified created policy, never a collection or reference."
  }
  assert {
    condition     = msgraph_resource_action.remove.when == "destroy"
    error_message = "Register DELETE without issuing it on apply."
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-111111111111"
    error_message = "Expose the captured owned identity for Conditional Access."
  }
}

run "updates_metadata_without_recreating_policy" {
  command = apply
  variables {
    displayName = "Reviewed passkeys"
    description = "Custom restrictions"
  }
  assert {
    condition     = msgraph_resource_action.policy.body.displayName == "Restricted passkeys"
    error_message = "The initial POST must not be resent for an in-place update."
  }
  assert {
    condition     = jsonencode(msgraph_update_resource.metadata.body) == jsonencode({ displayName = "Reviewed passkeys", description = "Custom restrictions" })
    error_message = "PATCH must contain metadata only."
  }
}

run "changes_combinations_through_action" {
  command = apply
  variables {
    allowedCombinations = ["password,sms", "fido2"]
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["password, sms", "fido2"] } } }
  }
  assert {
    condition     = jsonencode(msgraph_resource_action.combinations.body) == jsonencode({ allowedCombinations = ["fido2", "password,sms"] })
    error_message = "Replace the action with the full sorted combination set."
  }
  assert {
    condition     = msgraph_resource_action.combinations.resource_url == "policies/authenticationStrengthPolicies/11111111-1111-1111-1111-111111111111/updateAllowedCombinations"
    error_message = "Use the documented combinations action on the created policy."
  }
  assert {
    condition     = jsonencode(msgraph_resource_action.policy.body.allowedCombinations) == jsonencode(["fido2"])
    error_message = "Changing combinations must not replay the policy POST."
  }
}

run "creates_both_derived_configuration_types" {
  command = apply
  variables {
    allowedCombinations = ["fido2", "x509CertificateMultiFactor"]
    allowedAAGUIDs      = ["AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"]
    x509CertificateCombinationConfigurations = {
      x509CertificateMultiFactor = { allowedIssuerSkis = ["AABBCC", "aabbcc", "DdEeFf"], allowedPolicyOIDs = ["1.2.3.4"] }
    }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2", "x509CertificateMultiFactor"] } } }
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { id = "22222222-2222-2222-2222-222222222222", output = { configuration = { id = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", appliesToCombinations = ["fido2"], allowedAAGUIDs = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] } } }
  }
  override_resource {
    target = msgraph_resource.configuration["x509CertificateMultiFactor"]
    values = { id = "22222222-2222-2222-2222-222222222222", output = { configuration = { id = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", appliesToCombinations = ["x509CertificateMultiFactor"], allowedIssuerSkis = ["AaBbCc", "DDEEFF"], allowedPolicyOIDs = ["1.2.3.4"] } } }
  }
  assert {
    condition = alltrue([
      for configuration in msgraph_resource.configuration :
      configuration.url == "policies/authenticationStrengthPolicies/11111111-1111-1111-1111-111111111111/combinationConfigurations"
    ])
    error_message = "Every combination configuration must use the reviewed canonical parent, including descendant operations."
  }
  assert {
    condition     = jsonencode(msgraph_resource.configuration["fido2"].body) == jsonencode({ "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", appliesToCombinations = ["fido2"], allowedAAGUIDs = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"] })
    error_message = "FIDO2 needs a concrete discriminator and sorted canonical AAGUIDs."
  }
  assert {
    condition     = jsonencode(msgraph_resource.configuration["x509CertificateMultiFactor"].body) == jsonencode({ "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", appliesToCombinations = ["x509CertificateMultiFactor"], allowedIssuerSkis = ["aabbcc", "ddeeff"], allowedPolicyOIDs = ["1.2.3.4"] })
    error_message = "Certificate restrictions must use documented Graph keys."
  }
}

run "ski_case_only_change_keeps_configuration" {
  command = apply
  variables {
    allowedCombinations = ["fido2", "x509CertificateMultiFactor"]
    allowedAAGUIDs      = ["AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"]
    x509CertificateCombinationConfigurations = {
      x509CertificateMultiFactor = { allowedIssuerSkis = ["aabbcc", "ddeeff"], allowedPolicyOIDs = ["1.2.3.4"] }
    }
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["fido2", "x509CertificateMultiFactor"] } } }
  }
  override_resource {
    target = msgraph_resource.configuration["x509CertificateMultiFactor"]
    values = { id = "44444444-4444-4444-4444-444444444444", output = { configuration = { id = "44444444-4444-4444-4444-444444444444", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", appliesToCombinations = ["x509CertificateMultiFactor"], allowedIssuerSkis = ["AABBCC", "DDEEFF"], allowedPolicyOIDs = ["1.2.3.4"] } } }
  }
  assert {
    condition     = output.combinationConfigurationIds["x509CertificateMultiFactor"] == "22222222-2222-2222-2222-222222222222"
    error_message = "A case-only SKI change or case-equivalent duplicate removal must keep the configuration ID."
  }
}

run "restriction_change_replaces_child_only" {
  command = apply
  variables {
    allowedAAGUIDs = ["bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"]
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { id = "33333333-3333-3333-3333-333333333333", output = { configuration = { id = "33333333-3333-3333-3333-333333333333", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", appliesToCombinations = ["fido2"], allowedAAGUIDs = ["bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"] } } }
  }
  assert {
    condition     = output.combinationConfigurationIds["fido2"] == "33333333-3333-3333-3333-333333333333"
    error_message = "Restriction changes must replace the configuration."
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-111111111111"
    error_message = "Child replacement must preserve the policy identity."
  }
}

run "rejects_configuration_for_disallowed_method" {
  command = plan
  variables {
    allowedCombinations = ["password"]
    allowedAAGUIDs      = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  expect_failures = [msgraph_resource.configuration["fido2"]]
}
