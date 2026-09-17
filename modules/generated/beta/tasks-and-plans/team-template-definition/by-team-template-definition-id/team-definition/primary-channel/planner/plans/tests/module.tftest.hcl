# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "teamTemplateDefinition/test-parent-id/teamDefinition/primaryChannel/planner/plans"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["container", "contentSensitivityLabelAssignment", "creationSource", "owner", "sharedWithContainers", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_template_definition_id = "test-parent-id"
    owner                       = "example"
    shared_with_containers      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["owner"]) == jsonencode("example")
    error_message = "owner must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sharedWithContainers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.plannerSharedWithContainer" }])
    error_message = "sharedWithContainers must preserve typed values and omit nested nulls."
  }
}
