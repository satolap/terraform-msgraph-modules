# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "education/classes/test-parent-id/assignments/test-parent-id/submissions/test-parent-id/submittedResources"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignmentResourceUrl", "dependentResources", "resource"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    education_class_id      = "test-parent-id"
    education_assignment_id = "test-parent-id"
    education_submission_id = "test-parent-id"
    assignment_resource_url = "example"
    dependent_resources     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentResourceUrl"]) == jsonencode("example")
    error_message = "assignmentResourceUrl must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dependentResources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.educationSubmissionResource" }])
    error_message = "dependentResources must preserve typed values and omit nested nulls."
  }
}
