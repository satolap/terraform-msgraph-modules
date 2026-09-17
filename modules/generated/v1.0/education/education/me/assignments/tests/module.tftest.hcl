# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "education/me/assignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["addToCalendarAction", "addedStudentAction", "allowLateSubmissions", "allowStudentsToAddResourcesToSubmission", "assignTo", "classId", "closeDateTime", "displayName", "dueDateTime", "grading", "gradingCategory", "gradingScheme", "instructions", "languageTag", "moduleUrl", "notificationChannelUrl", "resources", "rubric"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    class_id               = "example"
    allow_late_submissions = false
    resources              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["classId"]) == jsonencode("example")
    error_message = "classId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowLateSubmissions"]) == jsonencode(false)
    error_message = "allowLateSubmissions must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.educationAssignmentResource" }])
    error_message = "resources must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    add_to_calendar_action = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.add_to_calendar_action]
}
