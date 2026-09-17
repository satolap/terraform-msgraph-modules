# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "onPremisesPublishingProfiles/test-parent-id/agentGroups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "isDefault", "publishingType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
    display_name                      = "example"
    is_default                        = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefault"]) == jsonencode(false)
    error_message = "isDefault must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
    publishing_type                   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.publishing_type]
}
