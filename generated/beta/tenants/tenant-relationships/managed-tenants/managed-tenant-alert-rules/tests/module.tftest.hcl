# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managedTenantAlertRules"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alertDisplayName", "alertTTL", "alerts", "createdByUserId", "createdDateTime", "description", "displayName", "lastActionByUserId", "lastActionDateTime", "lastRunDateTime", "notificationFinalDestinations", "ruleDefinition", "severity", "targets", "tenantIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_display_name = "example"
    alert_ttl          = -2147483648
    alerts             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertDisplayName"]) == jsonencode("example")
    error_message = "alertDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertTTL"]) == jsonencode(-2147483648)
    error_message = "alertTTL must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alerts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedTenants.managedTenantAlert" }])
    error_message = "alerts must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    notification_final_destinations = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.notification_final_destinations]
}
