# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/dataSecurityAndGovernance/activities/contentActivities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["contentMetadata", "scopeIdentifier", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id          = "test-parent-id"
    scope_identifier = "example"
    content_metadata = { "activityMetadata" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["scopeIdentifier"]) == jsonencode("example")
    error_message = "scopeIdentifier must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentMetadata"]) == jsonencode({ "@odata.type" = "#microsoft.graph.processContentRequest" })
    error_message = "contentMetadata must preserve typed values and omit nested nulls."
  }
}
