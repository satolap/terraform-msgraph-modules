# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/credentialUserRegistrationsSummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["tenantLicenseType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    tenant_license_type = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["tenantLicenseType"]) == jsonencode("example")
    error_message = "tenantLicenseType must preserve typed values and omit nested nulls."
  }
}
