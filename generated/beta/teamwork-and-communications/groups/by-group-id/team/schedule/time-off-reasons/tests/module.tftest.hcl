# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/team/schedule/timeOffReasons"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["code", "createdBy", "displayName", "iconType", "isActive"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id  = "test-parent-id"
    code      = "example"
    is_active = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["code"]) == jsonencode("example")
    error_message = "code must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isActive"]) == jsonencode(false)
    error_message = "isActive must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    group_id  = "test-parent-id"
    icon_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.icon_type]
}
