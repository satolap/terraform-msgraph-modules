# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    certificate_based_application_configuration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "directory/certificateAuthorities/certificateBasedApplicationConfigurations/test-parent-id/trustedCertificateAuthorities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certificate", "isRootAuthority", "issuer", "issuerSubjectKeyIdentifier"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    certificate_based_application_configuration_id = "test-parent-id"
    certificate                                    = "example"
    is_root_authority                              = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificate"]) == jsonencode("example")
    error_message = "certificate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isRootAuthority"]) == jsonencode(false)
    error_message = "isRootAuthority must preserve typed values and omit nested nulls."
  }
}
