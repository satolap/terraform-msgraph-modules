# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/assignmentPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedTargetScope", "automaticRequestSettings", "createdDateTime", "customExtensionStageSettings", "description", "displayName", "expiration", "modifiedDateTime", "notificationSettings", "questions", "requestApprovalSettings", "requestorSettings", "reviewSettings", "specificAllowedTargets"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time               = "2026-01-01T00:00:00Z"
    custom_extension_stage_settings = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customExtensionStageSettings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.customExtensionStageSetting" }])
    error_message = "customExtensionStageSettings must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allowed_target_scope = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_target_scope]
}
