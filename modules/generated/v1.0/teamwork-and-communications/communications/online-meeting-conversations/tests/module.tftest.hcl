# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "communications/onlineMeetingConversations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["creationMode", "messages", "moderationState", "onlineMeeting", "onlineMeetingId", "organizer", "starter", "starterId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    creation_mode  = "none"
    online_meeting = { "allowAttendeeToEnableCamera" = null }
    messages       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["creationMode"]) == jsonencode("none")
    error_message = "creationMode must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["onlineMeeting"]) == jsonencode({ "@odata.type" = "#microsoft.graph.onlineMeeting" })
    error_message = "onlineMeeting must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["messages"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.engagementConversationMessage" }])
    error_message = "messages must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    creation_mode = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.creation_mode]
}
