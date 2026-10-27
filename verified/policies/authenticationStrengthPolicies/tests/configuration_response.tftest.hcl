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
  displayName          = "Custom strength"
  allowedCombinations  = ["fido2"]
}

run "refuses_unverified_configuration_response" {
  command = apply
  variables {
    allowedAAGUIDs = ["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { id = "22222222-2222-2222-2222-222222222222", output = { configuration = {} } }
  }
  expect_failures = [msgraph_resource.configuration["fido2"]]
}

# The failed first run leaves the policy and ownership saved but no remove
# action. The pytest regression inspects verbose Terraform state to prove it.
run "repairs_configuration_and_registers_policy_delete" {
  command = apply
  variables {
    allowedAAGUIDs = ["bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"]
  }
  override_resource {
    target = msgraph_resource.configuration["fido2"]
    values = { id = "22222222-2222-2222-2222-222222222222", output = { configuration = { id = "22222222-2222-2222-2222-222222222222", "@odata.type" = "#microsoft.graph.fido2CombinationConfiguration", appliesToCombinations = ["fido2"], allowedAAGUIDs = ["bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"] } } }
  }
  assert {
    condition     = msgraph_resource_action.remove.when == "destroy"
    error_message = "Only a successful repair completes policy deletion registration."
  }
}

run "refuses_different_ski_material" {
  command = apply
  variables {
    allowedCombinations = ["x509CertificateMultiFactor"]
    x509CertificateCombinationConfigurations = {
      x509CertificateMultiFactor = { allowedIssuerSkis = ["AABBCC"] }
    }
  }
  override_resource {
    target = msgraph_resource.configuration["x509CertificateMultiFactor"]
    values = { id = "33333333-3333-3333-3333-333333333333", output = { configuration = { id = "33333333-3333-3333-3333-333333333333", "@odata.type" = "#microsoft.graph.x509CertificateCombinationConfiguration", appliesToCombinations = ["x509CertificateMultiFactor"], allowedIssuerSkis = ["DDEEFF"] } } }
  }
  expect_failures = [msgraph_resource.configuration["x509CertificateMultiFactor"]]
}
