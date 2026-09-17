# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/attackSimulation/trainings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["availabilityStatus", "createdBy", "createdDateTime", "customUrl", "description", "displayName", "durationInMinutes", "source", "hasEvaluation", "languageDetails", "lastModifiedBy", "lastModifiedDateTime", "supportedLocales", "tags", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time   = "2026-01-01T00:00:00Z"
    has_evaluation      = false
    duration_in_minutes = -2147483648
    language_details    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasEvaluation"]) == jsonencode(false)
    error_message = "hasEvaluation must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["durationInMinutes"]) == jsonencode(-2147483648)
    error_message = "durationInMinutes must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["languageDetails"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.trainingLanguageDetail" }])
    error_message = "languageDetails must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    availability_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.availability_status]
}
