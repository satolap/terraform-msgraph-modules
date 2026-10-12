# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsAnomaly"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["anomalyFirstOccurrenceDateTime", "anomalyId", "anomalyLatestOccurrenceDateTime", "anomalyName", "anomalyType", "assetName", "assetPublisher", "assetVersion", "detectionModelId", "deviceImpactedCount", "issueId", "severity", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    anomaly_first_occurrence_date_time = "2026-01-01T00:00:00Z"
    device_impacted_count              = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["anomalyFirstOccurrenceDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "anomalyFirstOccurrenceDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceImpactedCount"]) == jsonencode(-2147483648)
    error_message = "deviceImpactedCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    anomaly_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.anomaly_type]
}
