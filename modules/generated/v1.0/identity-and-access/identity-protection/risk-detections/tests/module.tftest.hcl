# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityProtection/riskDetections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activity", "activityDateTime", "additionalInfo", "correlationId", "detectedDateTime", "detectionTimingType", "source", "ipAddress", "lastUpdatedDateTime", "location", "requestId", "riskDetail", "riskEventType", "riskLevel", "riskState", "tokenIssuerType", "userDisplayName", "userId", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    activity = "signin"
    location = { "city" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activity"]) == jsonencode("signin")
    error_message = "activity must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["location"]) == jsonencode({ "@odata.type" = "#microsoft.graph.signInLocation" })
    error_message = "location must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    activity = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.activity]
}
