# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "solutions/backupRestore/oneDriveForBusinessProtectionPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["billingPolicyId", "createdBy", "createdDateTime", "displayName", "driveExclusionUnits", "driveExclusionUnitsBulkAdditionJobs", "driveInclusionRules", "driveProtectionUnits", "driveProtectionUnitsBulkAdditionJobs", "isEnabled", "lastModifiedBy", "lastModifiedDateTime", "offboardRequestedDateTime", "protectionMode", "protectionPolicyArtifactCount", "retentionSettings", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    billing_policy_id     = "example"
    is_enabled            = false
    drive_exclusion_units = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["billingPolicyId"]) == jsonencode("example")
    error_message = "billingPolicyId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["driveExclusionUnits"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.driveExclusionUnit" }])
    error_message = "driveExclusionUnits must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    protection_mode = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.protection_mode]
}
