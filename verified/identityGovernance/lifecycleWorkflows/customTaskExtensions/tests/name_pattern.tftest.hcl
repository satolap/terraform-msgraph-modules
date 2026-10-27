mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      output = {
        created_date_time       = "2026-01-01T00:00:00Z"
        last_modified_date_time = "2026-01-01T00:00:00Z"
      }
    }
  }
}

variables {
  display_name = "Example ORG-DEV-Extension"

  logic_app = {
    subscription_id         = "11111111-1111-4111-8111-111111111111"
    resource_group_name     = "rg-example"
    logic_app_workflow_name = "example-logic-app"
  }

  authentication_resource_id = "22222222-2222-4222-8222-222222222222"
}

run "accepts_any_display_name_without_name_pattern" {
  command = plan

  variables {
    display_name = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.extension.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any display_name must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = plan

  variables {
    name_pattern = "^Example ORG-(DEV|PRD)-"
  }

  assert {
    condition     = msgraph_resource.extension.body.displayName == "Example ORG-DEV-Extension"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    name_pattern = "^Example ORG-PRD-"
  }

  expect_failures = [msgraph_resource.extension]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "("
  }

  expect_failures = [var.name_pattern]
}
