# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    online_meeting_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "app/onlineMeetings/test-parent-id/registration/customQuestions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["answerInputType", "answerOptions", "displayName", "isRequired"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    online_meeting_id = "test-parent-id"
    display_name      = "example"
    is_required       = false
    answer_options    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isRequired"]) == jsonencode(false)
    error_message = "isRequired must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["answerOptions"]) == jsonencode(["example"])
    error_message = "answerOptions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    online_meeting_id = "test-parent-id"
    answer_input_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.answer_input_type]
}
