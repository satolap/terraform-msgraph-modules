# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_management_compliance_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/compliancePolicies/test-parent-id/scheduledActionsForRule"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["ruleName", "scheduledActionConfigurations"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_management_compliance_policy_id = "test-parent-id"
    rule_name                              = "example"
    scheduled_action_configurations        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["ruleName"]) == jsonencode("example")
    error_message = "ruleName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["scheduledActionConfigurations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementComplianceActionItem" }])
    error_message = "scheduledActionConfigurations must preserve typed values and omit nested nulls."
  }
}
