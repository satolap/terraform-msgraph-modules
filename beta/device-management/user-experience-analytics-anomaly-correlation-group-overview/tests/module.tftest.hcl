# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsAnomalyCorrelationGroupOverview"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["anomalyCorrelationGroupCount", "anomalyId", "correlationGroupAnomalousDeviceCount", "correlationGroupAtRiskDeviceCount", "correlationGroupDeviceCount", "correlationGroupFeatures", "correlationGroupId", "correlationGroupPrevalence", "correlationGroupPrevalencePercentage", "totalDeviceCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    anomaly_id                      = "example"
    anomaly_correlation_group_count = -2147483648
    correlation_group_features      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["anomalyId"]) == jsonencode("example")
    error_message = "anomalyId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["anomalyCorrelationGroupCount"]) == jsonencode(-2147483648)
    error_message = "anomalyCorrelationGroupCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["correlationGroupFeatures"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.userExperienceAnalyticsAnomalyCorrelationGroupFeature" }])
    error_message = "correlationGroupFeatures must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    correlation_group_prevalence = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.correlation_group_prevalence]
}
