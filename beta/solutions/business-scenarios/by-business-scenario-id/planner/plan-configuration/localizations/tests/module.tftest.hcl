# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    business_scenario_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/businessScenarios/test-parent-id/planner/planConfiguration/localizations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["buckets", "languageTag", "planTitle"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    business_scenario_id = "test-parent-id"
    language_tag         = "example"
    buckets              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["languageTag"]) == jsonencode("example")
    error_message = "languageTag must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["buckets"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.plannerPlanConfigurationBucketLocalization" }])
    error_message = "buckets must preserve typed values and omit nested nulls."
  }
}
