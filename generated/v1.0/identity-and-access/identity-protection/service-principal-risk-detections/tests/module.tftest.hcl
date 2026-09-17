# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityProtection/servicePrincipalRiskDetections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activity", "activityDateTime", "additionalInfo", "appId", "correlationId", "detectedDateTime", "detectionTimingType", "source", "ipAddress", "keyIds", "lastUpdatedDateTime", "location", "requestId", "riskDetail", "riskEventType", "riskLevel", "riskState", "servicePrincipalDisplayName", "servicePrincipalId", "tokenIssuerType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activity_date_time = "2026-01-01T00:00:00Z"
    key_ids            = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "activityDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["keyIds"]) == jsonencode(["example"])
    error_message = "keyIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    activity = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.activity]
}
