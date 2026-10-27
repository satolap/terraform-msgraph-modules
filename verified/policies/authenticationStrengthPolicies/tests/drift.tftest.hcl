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

run "creates_policy_for_drift_tests" {
  command = apply
}
run "refuses_combination_drift" {
  command = plan
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["password"] } } }
  }
  expect_failures = [data.msgraph_resource.current]
}
run "refuses_missing_current_identity" {
  command = plan
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = {} } }
  }
  expect_failures = [data.msgraph_resource.current]
}
run "accepts_every_pinned_combination" {
  command = apply
  variables {
    allowedCombinations = ["windowsHelloForBusiness", "fido2", "x509CertificateMultiFactor", "deviceBasedPush", "temporaryAccessPassOneTime", "temporaryAccessPassMultiUse", "password,microsoftAuthenticatorPush", "password,softwareOath", "password,hardwareOath", "password,sms", "password,voice", "federatedMultiFactor", "microsoftAuthenticatorPush,federatedSingleFactor", "softwareOath,federatedSingleFactor", "hardwareOath,federatedSingleFactor", "sms,federatedSingleFactor", "voice,federatedSingleFactor", "x509CertificateSingleFactor", "sms", "password", "federatedSingleFactor", "email"]
  }
  override_data {
    target = data.msgraph_resource.current
    values = { output = { policy = { id = "11111111-1111-1111-1111-111111111111", policyType = "custom", allowedCombinations = ["windowsHelloForBusiness", "fido2", "x509CertificateMultiFactor", "deviceBasedPush", "temporaryAccessPassOneTime", "temporaryAccessPassMultiUse", "password,microsoftAuthenticatorPush", "password,softwareOath", "password,hardwareOath", "password,sms", "password,voice", "federatedMultiFactor", "microsoftAuthenticatorPush,federatedSingleFactor", "softwareOath,federatedSingleFactor", "hardwareOath,federatedSingleFactor", "sms,federatedSingleFactor", "voice,federatedSingleFactor", "x509CertificateSingleFactor", "sms", "password", "federatedSingleFactor", "email"] } } }
  }
}
