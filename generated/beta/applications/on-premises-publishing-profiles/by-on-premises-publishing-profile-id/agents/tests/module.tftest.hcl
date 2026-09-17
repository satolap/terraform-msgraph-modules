# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "onPremisesPublishingProfiles/test-parent-id/agents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["status", "supportedPublishingTypes"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
    status                            = "active"
    supported_publishing_types        = ["applicationProxy"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["status"]) == jsonencode("active")
    error_message = "status must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["supportedPublishingTypes"]) == jsonencode(["applicationProxy"])
    error_message = "supportedPublishingTypes must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    on_premises_publishing_profile_id = "test-parent-id"
    status                            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
