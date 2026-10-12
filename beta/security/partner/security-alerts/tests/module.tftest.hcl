# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/partner/securityAlerts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activityLogs", "additionalDetails", "affectedResources", "alertType", "catalogOfferId", "confidenceLevel", "customerTenantId", "description", "detectedDateTime", "displayName", "firstObservedDateTime", "isTest", "lastObservedDateTime", "resolvedBy", "resolvedOnDateTime", "resolvedReason", "severity", "status", "subscriptionId", "valueAddedResellerTenantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_type    = "example"
    is_test       = false
    activity_logs = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertType"]) == jsonencode("example")
    error_message = "alertType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isTest"]) == jsonencode(false)
    error_message = "isTest must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityLogs"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.partner.security.activityLog" }])
    error_message = "activityLogs must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    confidence_level = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.confidence_level]
}
