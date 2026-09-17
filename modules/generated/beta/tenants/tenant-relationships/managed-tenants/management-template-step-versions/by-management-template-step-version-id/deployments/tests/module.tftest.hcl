# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    management_template_step_version_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managementTemplateStepVersions/test-parent-id/deployments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdByUserId", "createdDateTime", "error", "lastActionByUserId", "lastActionDateTime", "status", "templateStepVersion", "tenantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    management_template_step_version_id = "test-parent-id"
    created_by_user_id                  = "example"
    template_step_version               = { "acceptedFor" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdByUserId"]) == jsonencode("example")
    error_message = "createdByUserId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["templateStepVersion"]) == jsonencode({ "@odata.type" = "#microsoft.graph.managedTenants.managementTemplateStepVersion" })
    error_message = "templateStepVersion must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    management_template_step_version_id = "test-parent-id"
    status                              = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
