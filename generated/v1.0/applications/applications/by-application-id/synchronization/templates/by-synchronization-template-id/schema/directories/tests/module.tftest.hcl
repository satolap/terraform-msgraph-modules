# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    application_id              = "test-parent-id"
    synchronization_template_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "applications/test-parent-id/synchronization/templates/test-parent-id/schema/directories"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["discoverabilities", "discoveryDateTime", "name", "objects"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    application_id              = "test-parent-id"
    synchronization_template_id = "test-parent-id"
    discoverabilities           = "None"
    objects                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["discoverabilities"]) == jsonencode("None")
    error_message = "discoverabilities must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["objects"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.objectDefinition" }])
    error_message = "objects must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    application_id              = "test-parent-id"
    synchronization_template_id = "test-parent-id"
    discoverabilities           = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.discoverabilities]
}
