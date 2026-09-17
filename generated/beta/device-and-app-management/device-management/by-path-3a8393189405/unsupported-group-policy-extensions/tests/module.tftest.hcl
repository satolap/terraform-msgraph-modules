# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyMigrationReports/test-parent-id/unsupportedGroupPolicyExtensions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["extensionType", "namespaceUrl", "nodeName", "settingScope"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    extension_type                   = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["extensionType"]) == jsonencode("example")
    error_message = "extensionType must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    setting_scope                    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.setting_scope]
}
