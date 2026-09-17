# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "directory/featureRolloutPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appliesTo", "description", "displayName", "feature", "isAppliedToOrganization", "isEnabled"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description                = "example"
    is_applied_to_organization = false
    applies_to                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAppliedToOrganization"]) == jsonencode(false)
    error_message = "isAppliedToOrganization must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliesTo"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.directoryObject" }])
    error_message = "appliesTo must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    feature = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.feature]
}
