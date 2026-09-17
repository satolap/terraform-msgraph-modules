# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "solutions/migrations/crossTenantMigrationJobs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["completeAfterDateTime", "displayName", "exchangeSettings", "jobType", "resourceType", "resources", "sourceTenantId", "status", "users", "workloads"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    complete_after_date_time = "2026-01-01T00:00:00Z"
    resources                = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completeAfterDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "completeAfterDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resources"]) == jsonencode(["example"])
    error_message = "resources must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    job_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.job_type]
}
