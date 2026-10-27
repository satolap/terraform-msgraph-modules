mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "11111111-1111-1111-1111-111111111111"
      output = {
        keyId         = "22222222-2222-2222-2222-222222222222"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [{
          keyId         = "22222222-2222-2222-2222-222222222222"
          displayName   = "Automation credential"
          startDateTime = "2026-01-01T00:00:00Z"
          endDateTime   = "2028-01-01T00:00:00Z"
        }]
      }
    }
  }
}

variables {
  acknowledge_secret_in_plan_output = true
  service_principal_id              = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
  displayName                       = "Automation credential"
}

run "rejects_empty_label" {
  command = plan
  variables { displayName = "" }
  expect_failures = [var.displayName]
}

run "rejects_whitespace_label" {
  command = plan
  variables { displayName = " label " }
  expect_failures = [var.displayName]
}

run "rejects_long_label" {
  command = plan
  variables { displayName = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" }
  expect_failures = [var.displayName]
}

run "rejects_object_id" {
  command = plan
  variables { service_principal_id = "not-a-guid" }
  expect_failures = [var.service_principal_id]
}

run "rejects_empty_rotation" {
  command = plan
  variables { rotation_trigger = " " }
  expect_failures = [var.rotation_trigger]
}

run "rejects_invalid_start" {
  command = plan
  variables { startDateTime = "2026-99-10T00:00:00Z" }
  expect_failures = [var.startDateTime]
}

run "rejects_non_utc_start" {
  command = plan
  variables { startDateTime = "2026-01-01T00:00:00+01:00" }
  expect_failures = [var.startDateTime]
}

run "rejects_invalid_end" {
  command = plan
  variables { endDateTime = "not-a-date" }
  expect_failures = [var.endDateTime]
}

run "rejects_end_without_start" {
  command = plan
  variables { endDateTime = "2028-01-01T00:00:00Z" }
  expect_failures = [var.endDateTime]
}

run "rejects_equal_dates" {
  command = plan
  variables {
    startDateTime = "2026-01-01T00:00:00Z"
    endDateTime   = "2026-01-01T00:00:00Z"
  }
  expect_failures = [var.endDateTime]
}

run "rejects_end_before_start" {
  command = plan
  variables {
    startDateTime = "2026-01-01T00:00:00Z"
    endDateTime   = "2025-01-01T00:00:00Z"
  }
  expect_failures = [var.endDateTime]
}

run "accepts_explicit_nulls_on_the_1_11_floor" {
  command = plan
  variables {
    startDateTime = null
    endDateTime   = null
  }
}

run "accepts_fractional_utc_dates" {
  command = plan
  variables {
    startDateTime = "2026-01-01T00:00:00.123Z"
    endDateTime   = "2027-01-01T00:00:00.1234567Z"
  }
}

run "rejects_a_past_expiration_even_after_a_valid_start" {
  command = plan
  variables {
    startDateTime = "2020-01-01T00:00:00Z"
    endDateTime   = "2021-01-01T00:00:00Z"
  }
  expect_failures = [var.endDateTime]
}
