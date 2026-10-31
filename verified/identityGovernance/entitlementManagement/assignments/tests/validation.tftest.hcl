# Input validation. Plans only; no request is sent.
mock_provider "null" {}
mock_provider "time" {}
mock_provider "msgraph" {}

variables {
  enable_destroy_cleanup = false
  target_id              = "11111111-1111-1111-1111-111111111111"
  access_package_id      = "22222222-2222-2222-2222-222222222222"
  assignment_policy_id   = "33333333-3333-3333-3333-333333333333"
}

run "rejects_a_subject_that_is_not_a_guid" {
  command = plan

  variables {
    target_id = "alice@contoso.com"
  }

  expect_failures = [var.target_id]
}

run "rejects_an_access_package_that_is_not_a_guid" {
  command = plan

  variables {
    access_package_id = "Sales"
  }

  expect_failures = [var.access_package_id]
}

run "rejects_a_policy_that_is_not_a_guid" {
  command = plan

  variables {
    assignment_policy_id = ""
  }

  expect_failures = [var.assignment_policy_id]
}

run "rejects_an_adopted_assignment_that_is_not_a_guid" {
  command = plan

  variables {
    adopt_assignment_id = "latest"
  }

  expect_failures = [var.adopt_assignment_id]
}

run "rejects_an_empty_justification" {
  command = plan

  variables {
    justification = "  "
  }

  expect_failures = [var.justification]
}

run "rejects_a_malformed_start_time" {
  command = plan

  variables {
    schedule = { startDateTime = "tomorrow" }
  }

  expect_failures = [var.schedule]
}

run "rejects_an_unknown_expiration_type" {
  command = plan

  variables {
    schedule = { expiration = { type = "never" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_after_date_time_without_an_end" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDateTime" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_an_end_with_the_wrong_type" {
  command = plan

  variables {
    schedule = { expiration = { type = "noExpiration", endDateTime = "2027-01-01T00:00:00Z" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_after_duration_without_a_duration" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDuration" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_a_duration_with_the_wrong_type" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDateTime", endDateTime = "2027-01-01T00:00:00Z", duration = "P1D" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_month_durations" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDuration", duration = "P1M" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_a_bare_period_designator" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDuration", duration = "P" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_a_time_designator_without_components" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDuration", duration = "PT" } }
  }

  expect_failures = [var.schedule]
}

run "rejects_a_malformed_end_date" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDateTime", endDateTime = "2027-01-01" } }
  }

  expect_failures = [var.schedule]
}

run "validates_a_schedule_update_like_a_schedule" {
  command = plan

  variables {
    schedule_update = { expiration = { type = "afterDuration" } }
  }

  expect_failures = [var.schedule_update]
}

run "rejects_an_unknown_update_expiration_type" {
  command = plan

  variables {
    schedule_update = { expiration = { type = "forever" } }
  }

  expect_failures = [var.schedule_update]
}

run "rejects_a_fractional_wait" {
  command = plan

  variables {
    verification_delay_seconds = 1.5
  }

  expect_failures = [var.verification_delay_seconds]
}

run "rejects_a_negative_wait" {
  command = plan

  variables {
    verification_delay_seconds = -1
  }

  expect_failures = [var.verification_delay_seconds]
}

run "accepts_day_and_time_durations" {
  command = plan

  variables {
    schedule = { expiration = { type = "afterDuration", duration = "P1DT8H" } }
  }

  assert {
    condition     = msgraph_resource_action.add[0].body.schedule.expiration.duration == "P1DT8H"
    error_message = "A duration of days and time must be accepted."
  }
}
