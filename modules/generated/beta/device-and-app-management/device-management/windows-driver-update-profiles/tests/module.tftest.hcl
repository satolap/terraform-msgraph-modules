# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsDriverUpdateProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["approvalType", "assignments", "createdDateTime", "deploymentDeferralInDays", "description", "deviceReporting", "displayName", "driverInventories", "inventorySyncStatus", "lastModifiedDateTime", "newUpdates", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    approval_type               = "manual"
    deployment_deferral_in_days = -2147483648
    assignments                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["approvalType"]) == jsonencode("manual")
    error_message = "approvalType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deploymentDeferralInDays"]) == jsonencode(-2147483648)
    error_message = "deploymentDeferralInDays must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.windowsDriverUpdateProfileAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    approval_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.approval_type]
}
