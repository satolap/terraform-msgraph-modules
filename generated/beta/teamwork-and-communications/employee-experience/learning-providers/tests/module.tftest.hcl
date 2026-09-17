# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "employeeExperience/learningProviders"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "isCourseActivitySyncEnabled", "learningContents", "learningCourseActivities", "loginWebUrl", "longLogoWebUrlForDarkTheme", "longLogoWebUrlForLightTheme", "squareLogoWebUrlForDarkTheme", "squareLogoWebUrlForLightTheme"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name                    = "example"
    is_course_activity_sync_enabled = false
    learning_contents               = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCourseActivitySyncEnabled"]) == jsonencode(false)
    error_message = "isCourseActivitySyncEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["learningContents"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.learningContent" }])
    error_message = "learningContents must preserve typed values and omit nested nulls."
  }
}
