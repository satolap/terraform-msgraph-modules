# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    permission_grant_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "policies/permissionGrantPolicies/test-parent-id/excludes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certifiedClientApplicationsOnly", "clientApplicationIds", "clientApplicationPublisherIds", "clientApplicationTenantIds", "clientApplicationsFromVerifiedPublisherOnly", "permissionClassification", "permissionType", "permissions", "resourceApplication", "scopeSensitivityLabels"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    permission_grant_policy_id         = "test-parent-id"
    permission_classification          = "example"
    certified_client_applications_only = false
    scope_sensitivity_labels           = { "labelKind" = null }
    client_application_ids             = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["permissionClassification"]) == jsonencode("example")
    error_message = "permissionClassification must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certifiedClientApplicationsOnly"]) == jsonencode(false)
    error_message = "certifiedClientApplicationsOnly must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["scopeSensitivityLabels"]) == jsonencode({ "@odata.type" = "#microsoft.graph.scopeSensitivityLabels" })
    error_message = "scopeSensitivityLabels must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clientApplicationIds"]) == jsonencode(["example"])
    error_message = "clientApplicationIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    permission_grant_policy_id = "test-parent-id"
    permission_type            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.permission_type]
}
