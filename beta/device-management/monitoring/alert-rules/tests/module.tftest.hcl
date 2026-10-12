# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/monitoring/alertRules"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alertRuleTemplate", "conditions", "description", "displayName", "enabled", "isSystemRule", "notificationChannels", "severity", "threshold"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_rule_template = "cloudPcProvisionScenario"
    enabled             = false
    threshold           = { "aggregation" = null }
    conditions          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertRuleTemplate"]) == jsonencode("cloudPcProvisionScenario")
    error_message = "alertRuleTemplate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enabled"]) == jsonencode(false)
    error_message = "enabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["threshold"]) == jsonencode({ "@odata.type" = "#microsoft.graph.deviceManagement.ruleThreshold" })
    error_message = "threshold must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["conditions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagement.ruleCondition" }])
    error_message = "conditions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    alert_rule_template = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.alert_rule_template]
}
