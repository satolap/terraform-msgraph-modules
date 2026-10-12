# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    certificate_based_auth_pki_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/test-parent-id/certificateAuthorities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certificate", "certificateAuthorityType", "certificateRevocationListUrl", "createdDateTime", "deletedDateTime", "deltaCertificateRevocationListUrl", "displayName", "expirationDateTime", "isIssuerHintEnabled", "issuer", "issuerSubjectKeyIdentifier", "thumbprint"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    certificate_based_auth_pki_id = "test-parent-id"
    certificate                   = "example"
    is_issuer_hint_enabled        = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificate"]) == jsonencode("example")
    error_message = "certificate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isIssuerHintEnabled"]) == jsonencode(false)
    error_message = "isIssuerHintEnabled must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    certificate_based_auth_pki_id = "test-parent-id"
    certificate_authority_type    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.certificate_authority_type]
}
