# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    education_class_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "education/classes/test-parent-id/assignmentSettings/gradingSchemes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "grades", "hidePointsDuringGrading"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    education_class_id         = "test-parent-id"
    display_name               = "example"
    hide_points_during_grading = false
    grades                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hidePointsDuringGrading"]) == jsonencode(false)
    error_message = "hidePointsDuringGrading must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["grades"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.educationGradingSchemeGrade" }])
    error_message = "grades must preserve typed values and omit nested nulls."
  }
}
