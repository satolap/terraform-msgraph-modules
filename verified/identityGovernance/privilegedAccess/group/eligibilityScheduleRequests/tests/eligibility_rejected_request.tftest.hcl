# A request Graph reports as rejected is an error, never accepted access.
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-2"
      output = {
        request_id         = "req-2"
        status             = "Denied"
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
  access_id                     = "owner"
  justification                 = "Offline contract test"
  start_date_time               = "2099-01-01T00:00:00Z"
  end_date_time                 = "2099-01-01T08:00:00Z"
  verification_delay_seconds    = 0
  fail_on_verification_mismatch = false
}

run "denied_request_fails_the_gate_even_when_mismatch_checks_are_off" {
  command = apply

  expect_failures = [terraform_data.verification_gate]
}
