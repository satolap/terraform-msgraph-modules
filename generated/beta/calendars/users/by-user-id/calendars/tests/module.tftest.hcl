# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/calendars"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedOnlineMeetingProviders", "calendarGroupId", "calendarPermissions", "color", "defaultOnlineMeetingProvider", "hexColor", "isDefaultCalendar", "isRemovable", "isTallyingResponses", "name"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id                          = "test-parent-id"
    calendar_group_id                = "example"
    is_default_calendar              = false
    allowed_online_meeting_providers = ["unknown"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["calendarGroupId"]) == jsonencode("example")
    error_message = "calendarGroupId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefaultCalendar"]) == jsonencode(false)
    error_message = "isDefaultCalendar must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedOnlineMeetingProviders"]) == jsonencode(["unknown"])
    error_message = "allowedOnlineMeetingProviders must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id = "test-parent-id"
    color   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.color]
}
