# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_compliance_policy_id                    = "test-parent-id"
    device_compliance_scheduled_action_for_rule_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceCompliancePolicies/test-parent-id/scheduledActionsForRule/test-parent-id/scheduledActionConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionType", "gracePeriodHours", "notificationMessageCCList", "notificationTemplateId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_compliance_policy_id                    = "test-parent-id"
    device_compliance_scheduled_action_for_rule_id = "test-parent-id"
    action_type                                    = "noAction"
    grace_period_hours                             = -2147483648
    notification_message_cc_list                   = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionType"]) == jsonencode("noAction")
    error_message = "actionType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["gracePeriodHours"]) == jsonencode(-2147483648)
    error_message = "gracePeriodHours must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["notificationMessageCCList"]) == jsonencode(["example"])
    error_message = "notificationMessageCCList must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_compliance_policy_id                    = "test-parent-id"
    device_compliance_scheduled_action_for_rule_id = "test-parent-id"
    action_type                                    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.action_type]
}
