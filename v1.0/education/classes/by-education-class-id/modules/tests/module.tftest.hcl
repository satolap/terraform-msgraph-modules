# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    education_class_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "education/classes/test-parent-id/modules"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "isPinned", "resources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    education_class_id = "test-parent-id"
    description        = "example"
    is_pinned          = false
    resources          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isPinned"]) == jsonencode(false)
    error_message = "isPinned must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.educationModuleResource" }])
    error_message = "resources must preserve typed values and omit nested nulls."
  }
}
