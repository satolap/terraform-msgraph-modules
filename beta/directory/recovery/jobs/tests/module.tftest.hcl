# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.entraRecoveryServices.recoveryJob"
  }

  assert {
    condition     = msgraph_resource.this.url == "directory/recovery/jobs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["filteringCriteria", "jobCompletionDateTime", "jobStartDateTime", "status", "targetStateDateTime", "totalChangedLinksCalculated", "totalChangedObjectsCalculated"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type                     = "#microsoft.graph.entraRecoveryServices.recoveryJob"
    job_completion_date_time       = "2026-01-01T00:00:00Z"
    total_changed_links_calculated = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.entraRecoveryServices.recoveryJob")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["jobCompletionDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "jobCompletionDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["totalChangedLinksCalculated"]) == jsonencode(-2147483648)
    error_message = "totalChangedLinksCalculated must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
