# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackageAssignmentPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessPackageCatalog", "accessPackageId", "accessPackageNotificationSettings", "accessReviewSettings", "canExtend", "createdBy", "createdDateTime", "customExtensionHandlers", "customExtensionStageSettings", "description", "displayName", "durationInDays", "expirationDateTime", "modifiedBy", "modifiedDateTime", "questions", "requestApprovalSettings", "requestorSettings", "verifiableCredentialSettings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_id         = "example"
    can_extend                = false
    duration_in_days          = -2147483648
    custom_extension_handlers = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessPackageId"]) == jsonencode("example")
    error_message = "accessPackageId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["canExtend"]) == jsonencode(false)
    error_message = "canExtend must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["durationInDays"]) == jsonencode(-2147483648)
    error_message = "durationInDays must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customExtensionHandlers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.customExtensionHandler" }])
    error_message = "customExtensionHandlers must preserve typed values and omit nested nulls."
  }
}
