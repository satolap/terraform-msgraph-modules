# Window and identity handling. A later run reuses the state of the first apply.
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-1"
      output = {
        request_id         = "req-1"
        status             = "Provisioned"
        target_schedule_id = null
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        schedules = []
        instances = []
      }
    }
  }
}

variables {
  principal_id                  = "11111111-1111-1111-1111-111111111111"
  group_id                      = "22222222-2222-2222-2222-222222222222"
  access_id                     = "member"
  justification                 = "Offline contract test"
  start_date_time               = "2099-01-01T00:00:00Z"
  end_date_time                 = "2099-01-01T08:00:00Z"
  verification_delay_seconds    = 0
  fail_on_verification_mismatch = false
}

run "submits_once_and_records_the_grant" {
  command = apply

  assert {
    condition     = output.state == "request_accepted_only"
    error_message = "An upcoming grant with nothing visible stays request_accepted_only."
  }
}

run "changed_end_is_refused_while_the_grant_is_upcoming" {
  command = plan

  variables {
    end_date_time = "2099-01-01T09:00:00Z"
  }

  expect_failures = [terraform_data.verification_gate]
}

run "changed_start_is_refused" {
  command = plan

  variables {
    start_date_time = "2099-01-01T01:00:00Z"
  }

  expect_failures = [terraform_data.verification_gate]
}

run "changed_principal_is_refused" {
  command = plan

  variables {
    principal_id = "44444444-4444-4444-4444-444444444444"
  }

  expect_failures = [terraform_data.verification_gate]
}

run "changed_group_or_access_is_refused" {
  command = plan

  variables {
    group_id  = "33333333-3333-3333-3333-333333333333"
    access_id = "owner"
  }

  expect_failures = [terraform_data.verification_gate]
}

run "reworded_justification_neither_replaces_nor_resends" {
  command = plan

  variables {
    justification = "A different wording of the same grant"
  }

  assert {
    condition     = msgraph_resource_action.request.id == "req-1"
    error_message = "A new justification must not replace the request."
  }
}

run "a_later_in_place_change_never_resends_the_request" {
  command = plan

  # The unchanged configuration plans no change to the request action at all.
  assert {
    condition     = msgraph_resource_action.request.id == "req-1" && output.request_id == "req-1"
    error_message = "The stored request must be left alone."
  }
}
