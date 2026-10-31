# v4.0.0 spelled the recurrence attributes in snake_case. Terraform drops an unknown object
# attribute silently (the series would never end, or lose its day), so the guard rejects an
# old name that carries a value.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "99999999-9999-9999-9999-999999999999"
    }
  }
}

variables {
  displayName               = "Quarterly review of the owned group"
  descriptionForAdmins      = "Offline fixture"
  descriptionForReviewers   = "No decisions are applied"
  group_id                  = "11111111-1111-1111-1111-111111111111"
  reviewer_user_ids         = ["22222222-2222-2222-2222-222222222222"]
  start_date                = "2030-01-15"
  instance_duration_in_days = 7
}

run "the_graph_names_are_accepted" {
  command = plan
  variables {
    recurrence = {
      type                = "absoluteMonthly"
      interval            = 1
      dayOfMonth          = 15
      numberOfOccurrences = 4
    }
  }
}

run "rejects_the_legacy_day_of_month" {
  command = plan
  variables {
    recurrence = {
      type         = "absoluteMonthly"
      interval     = 1
      dayOfMonth   = 15
      day_of_month = 15
    }
  }
  expect_failures = [var.recurrence]
}

run "rejects_the_legacy_number_of_occurrences" {
  command = plan
  variables {
    recurrence = {
      type                  = "weekly"
      interval              = 1
      number_of_occurrences = 4
    }
  }
  expect_failures = [var.recurrence]
}

run "an_explicit_null_legacy_value_is_accepted" {
  command = plan
  variables {
    recurrence = {
      type                  = "weekly"
      interval              = 1
      day_of_month          = null
      number_of_occurrences = null
    }
  }
}
