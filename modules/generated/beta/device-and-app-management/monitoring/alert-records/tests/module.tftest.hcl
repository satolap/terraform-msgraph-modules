# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "monitoring/alertRecords"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alertImpact", "alertRuleId", "alertRuleTemplate", "detectedDateTime", "displayName", "lastUpdatedDateTime", "resolvedDateTime", "severity", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_rule_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertRuleId"]) == jsonencode("example")
    error_message = "alertRuleId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    alert_rule_template = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.alert_rule_template]
}
