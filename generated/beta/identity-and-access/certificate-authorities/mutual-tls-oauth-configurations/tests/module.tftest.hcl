# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "certificateAuthorities/mutualTlsOauthConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certificateAuthorities", "deletedDateTime", "displayName", "tlsClientAuthParameter"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    deleted_date_time       = "2026-01-01T00:00:00Z"
    certificate_authorities = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deletedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "deletedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificateAuthorities"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.certificateAuthority" }])
    error_message = "certificateAuthorities must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    tls_client_auth_parameter = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.tls_client_auth_parameter]
}
