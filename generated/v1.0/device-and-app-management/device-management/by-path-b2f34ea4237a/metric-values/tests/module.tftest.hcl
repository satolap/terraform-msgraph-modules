# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_experience_analytics_category_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/userExperienceAnalyticsCategories/test-parent-id/metricValues"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["unit", "value"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_experience_analytics_category_id = "test-parent-id"
    unit                                  = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["unit"]) == jsonencode("example")
    error_message = "unit must preserve typed values and omit nested nulls."
  }
}
