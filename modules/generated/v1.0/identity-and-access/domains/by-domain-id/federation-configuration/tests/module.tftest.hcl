# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    domain_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "domains/test-parent-id/federationConfiguration"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activeSignInUri", "displayName", "federatedIdpMfaBehavior", "isSignedAuthenticationRequestRequired", "issuerUri", "metadataExchangeUri", "nextSigningCertificate", "passiveSignInUri", "passwordResetUri", "preferredAuthenticationProtocol", "promptLoginBehavior", "signOutUri", "signingCertificate", "signingCertificateUpdateStatus", "systemBrowserEnabledOn"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    domain_id                                 = "test-parent-id"
    active_sign_in_uri                        = "example"
    is_signed_authentication_request_required = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activeSignInUri"]) == jsonencode("example")
    error_message = "activeSignInUri must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isSignedAuthenticationRequestRequired"]) == jsonencode(false)
    error_message = "isSignedAuthenticationRequestRequired must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    domain_id                  = "test-parent-id"
    federated_idp_mfa_behavior = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.federated_idp_mfa_behavior]
}
