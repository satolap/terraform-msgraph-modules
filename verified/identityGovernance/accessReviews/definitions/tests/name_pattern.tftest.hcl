mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "99999999-9999-9999-9999-999999999999"
    }
  }
}

variables {
  display_name              = "Quarterly review"
  description_for_admins    = "Offline fixture"
  description_for_reviewers = "No decisions are applied"
  group_id                  = "11111111-1111-1111-1111-111111111111"
  reviewer_user_ids         = ["22222222-2222-2222-2222-222222222222"]
  start_date                = "2030-01-15"
  recurrence = {
    type     = "weekly"
    interval = 1
  }
  instance_duration_in_days = 7
}

# name_pattern: optional, null by default. When set, display_name must match it
# or the plan fails. The pattern uses placeholder segments, not a real convention.

run "accepts_any_display_name_without_name_pattern" {
  command = apply

  variables {
    display_name = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.this.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any display_name must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = apply

  variables {
    display_name = "Example ORG-DEV-Name"
    name_pattern = "ORG-(DEV|PRD)-"
  }

  assert {
    condition     = msgraph_resource.this.body.displayName == "Example ORG-DEV-Name"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    display_name = "Example without the prefix"
    name_pattern = "^ORG-(DEV|PRD)-"
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(unclosed"
  }

  expect_failures = [var.name_pattern]
}
