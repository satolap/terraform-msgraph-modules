# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "onPremisesPublishingProfiles/test-parent-id/connectorGroups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applications", "connectorGroupType", "members", "name", "region"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
    connector_group_type              = "applicationProxy"
    applications                      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["connectorGroupType"]) == jsonencode("applicationProxy")
    error_message = "connectorGroupType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applications"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.application" }])
    error_message = "applications must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
    connector_group_type              = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.connector_group_type]
}
