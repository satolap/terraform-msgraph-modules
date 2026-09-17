# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/tls/externalCertificateAuthorityCertificates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certificate", "chain", "commonName", "name", "organizationName", "status", "validity"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    certificate = "example"
    validity    = { "endDateTime" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificate"]) == jsonencode("example")
    error_message = "certificate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["validity"]) == jsonencode({ "@odata.type" = "#microsoft.graph.networkaccess.validityDate" })
    error_message = "validity must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
