# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_assignment_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackageAssignments/test-parent-id/accessPackageAssignmentRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessPackageAssignment", "answers", "customExtensionCalloutInstances", "expirationDateTime", "history", "isValidationOnly", "justification", "parameters"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_assignment_id = "test-parent-id"
    expiration_date_time         = "2026-01-01T00:00:00Z"
    is_validation_only           = false
    answers                      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["expirationDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "expirationDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isValidationOnly"]) == jsonencode(false)
    error_message = "isValidationOnly must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["answers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.accessPackageAnswer" }])
    error_message = "answers must preserve typed values and omit nested nulls."
  }
}
