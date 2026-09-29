# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/attackSimulation/trainings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["availabilityStatus", "createdBy", "createdDateTime", "description", "displayName", "durationInMinutes", "source", "hasEvaluation", "languageDetails", "lastModifiedBy", "lastModifiedDateTime", "supportedLocales", "tags", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    availability_status = "unknown"
    has_evaluation      = false
    duration_in_minutes = -2147483648
    created_by          = { "displayName" = null }
    language_details    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["availabilityStatus"]) == jsonencode("unknown")
    error_message = "availabilityStatus must preserve typed values and omit nested nulls."
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
    condition     = jsonencode(msgraph_resource.this.body["createdBy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.emailIdentity" })
    error_message = "createdBy must preserve typed values and omit nested nulls."
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
