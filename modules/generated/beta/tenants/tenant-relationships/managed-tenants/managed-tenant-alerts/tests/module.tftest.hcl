# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managedTenantAlerts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alertData", "alertDataReferenceStrings", "alertLogs", "alertRule", "alertRuleDisplayName", "apiNotifications", "assignedToUserId", "correlationCount", "correlationId", "createdByUserId", "createdDateTime", "emailNotifications", "lastActionByUserId", "lastActionDateTime", "message", "severity", "status", "tenantId", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_rule_display_name      = "example"
    correlation_count            = -2147483648
    alert_data_reference_strings = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertRuleDisplayName"]) == jsonencode("example")
    error_message = "alertRuleDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["correlationCount"]) == jsonencode(-2147483648)
    error_message = "correlationCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertDataReferenceStrings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedTenants.alertDataReferenceString" }])
    error_message = "alertDataReferenceStrings must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    severity = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.severity]
}
