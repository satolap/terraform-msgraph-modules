# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "auditLogs/signIns"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appDisplayName", "appId", "appliedConditionalAccessPolicies", "authenticationAppDeviceDetails", "clientAppUsed", "conditionalAccessStatus", "correlationId", "createdDateTime", "deviceDetail", "homeTenantId", "ipAddress", "isInteractive", "location", "resourceDisplayName", "resourceId", "resourceTenantId", "riskDetail", "riskEventTypes", "riskEventTypes_v2", "riskLevelAggregated", "riskLevelDuringSignIn", "riskState", "servicePrincipalId", "servicePrincipalName", "status", "userAgent", "userDisplayName", "userId", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_display_name                    = "example"
    is_interactive                      = false
    applied_conditional_access_policies = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDisplayName"]) == jsonencode("example")
    error_message = "appDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isInteractive"]) == jsonencode(false)
    error_message = "isInteractive must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliedConditionalAccessPolicies"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appliedConditionalAccessPolicy" }])
    error_message = "appliedConditionalAccessPolicies must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    conditional_access_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.conditional_access_status]
}
