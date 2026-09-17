# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    service_principal_creation_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "policies/servicePrincipalCreationPolicies/test-parent-id/excludes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applicationIds", "applicationPublisherIds", "applicationTenantIds", "applicationsFromVerifiedPublisherOnly", "certifiedApplicationsOnly"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    service_principal_creation_policy_id      = "test-parent-id"
    applications_from_verified_publisher_only = false
    application_ids                           = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationsFromVerifiedPublisherOnly"]) == jsonencode(false)
    error_message = "applicationsFromVerifiedPublisherOnly must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationIds"]) == jsonencode(["example"])
    error_message = "applicationIds must preserve typed values and omit nested nulls."
  }
}
