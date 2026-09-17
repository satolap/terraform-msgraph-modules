# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "solutions/virtualEvents/townhalls"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["audience", "capacity", "coOrganizers", "createdBy", "description", "displayName", "endDateTime", "externalEventInformation", "invitedAttendees", "isInviteOnly", "isRegistrationRequired", "presenters", "registrationConfiguration", "registrations", "sessions", "settings", "startDateTime", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name   = "example"
    is_invite_only = false
    capacity       = -2147483648
    co_organizers  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isInviteOnly"]) == jsonencode(false)
    error_message = "isInviteOnly must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["capacity"]) == jsonencode(-2147483648)
    error_message = "capacity must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["coOrganizers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.communicationsUserIdentity" }])
    error_message = "coOrganizers must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    audience = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.audience]
}
