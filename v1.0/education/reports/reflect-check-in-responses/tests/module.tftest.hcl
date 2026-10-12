# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "education/reports/reflectCheckInResponses"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["checkInId", "checkInTitle", "classId", "createdDateTime", "creatorId", "isClosed", "responderId", "responseEmotion", "responseFeedback", "submitDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    check_in_id = "example"
    is_closed   = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["checkInId"]) == jsonencode("example")
    error_message = "checkInId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isClosed"]) == jsonencode(false)
    error_message = "isClosed must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    response_emotion = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.response_emotion]
}
