# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    calendar_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/calendars/test-parent-id/calendarPermissions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedRoles", "isInsideOrganization", "isRemovable", "role"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    calendar_id            = "test-parent-id"
    is_inside_organization = false
    allowed_roles          = ["none"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isInsideOrganization"]) == jsonencode(false)
    error_message = "isInsideOrganization must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedRoles"]) == jsonencode(["none"])
    error_message = "allowedRoles must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    calendar_id = "test-parent-id"
    role        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.role]
}
