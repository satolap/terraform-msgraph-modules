# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/calendars"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedOnlineMeetingProviders", "calendarPermissions", "canEdit", "canShare", "canViewPrivateItems", "color", "defaultOnlineMeetingProvider", "isDefaultCalendar", "isRemovable", "isTallyingResponses", "name", "owner"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    name                             = "example"
    can_edit                         = false
    allowed_online_meeting_providers = ["unknown"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["name"]) == jsonencode("example")
    error_message = "name must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["canEdit"]) == jsonencode(false)
    error_message = "canEdit must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedOnlineMeetingProviders"]) == jsonencode(["unknown"])
    error_message = "allowedOnlineMeetingProviders must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    color = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.color]
}
