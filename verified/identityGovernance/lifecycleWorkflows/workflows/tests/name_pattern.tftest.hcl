mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      output = {
        version               = 1
        is_enabled            = false
        is_scheduling_enabled = false
      }
    }
  }
}

variables {
  display_name = "Example ORG-DEV-Onboarding"
  category     = "joiner"

  execution_conditions = {
    type = "on_demand"
  }

  tasks = [{ task = "enable_user_account", display_name = "Enable" }]
}

run "accepts_any_display_name_without_name_pattern" {
  command = plan

  variables {
    display_name = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.workflow.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any display_name must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = plan

  variables {
    name_pattern = "ORG-(DEV|PRD)-"
  }

  assert {
    condition     = msgraph_resource.workflow.body.displayName == "Example ORG-DEV-Onboarding"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    display_name = "Example without the prefix"
    name_pattern = "^ORG-(DEV|PRD)-"
  }

  expect_failures = [msgraph_resource.workflow]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(unclosed"
  }

  expect_failures = [var.name_pattern]
}
