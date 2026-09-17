# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_experience_analytics_work_from_anywhere_metric_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsWorkFromAnywhereMetrics/test-parent-id/metricDevices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["healthStatus", "upgradeEligibility"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_experience_analytics_work_from_anywhere_metric_id = "test-parent-id"
    health_status                                          = "unknown"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["healthStatus"]) == jsonencode("unknown")
    error_message = "healthStatus must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_experience_analytics_work_from_anywhere_metric_id = "test-parent-id"
    health_status                                          = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.health_status]
}
