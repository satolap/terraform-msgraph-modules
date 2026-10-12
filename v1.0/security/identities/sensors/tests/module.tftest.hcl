# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/identities/sensors"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "deploymentStatus", "displayName", "domainName", "version", "healthIssues", "healthStatus", "openHealthIssuesCount", "sensorType", "serviceStatus", "settings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time        = "2026-01-01T00:00:00Z"
    open_health_issues_count = 0
    settings                 = { "description" = null }
    health_issues            = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["openHealthIssuesCount"]) == jsonencode(0)
    error_message = "openHealthIssuesCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.security.sensorSettings" })
    error_message = "settings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["healthIssues"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.healthIssue" }])
    error_message = "healthIssues must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    deployment_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.deployment_status]
}
