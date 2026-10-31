# An assignment that v4.0.0 applied with a schedule update keeps its saved state after the
# nested attributes took Graph's names: the stored update input keeps the v4.0.0 shape, so
# terraform_data.update_input does not change, replace_triggered_by does not fire and no
# second adminUpdate is sent. Mocked providers: the read-backs are overrides.
mock_provider "null" {}
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-00000000-0000-0000-0000-000000000001"
      output = {
        request_id = "req-00000000-0000-0000-0000-000000000001"
        state      = "delivered"
        status     = "Delivered"
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        state  = "delivered"
        status = "Delivered"
        assignments = [
          {
            id               = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            state            = "delivered"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }
}

variables {
  enable_destroy_cleanup     = false
  target_id                  = "11111111-1111-1111-1111-111111111111"
  access_package_id          = "22222222-2222-2222-2222-222222222222"
  assignment_policy_id       = "33333333-3333-3333-3333-333333333333"
  verification_delay_seconds = 0
}

run "v4_0_0_applies_a_schedule_update" {
  state_key = "upgrade"
  command   = apply
  module { source = "./tests/previous" }

  variables {
    schedule_update = {
      start_date_time = "2026-11-01T00:00:00Z"
      expiration = {
        type     = "afterDuration"
        duration = "P90D"
      }
    }
  }

  override_resource {
    target = msgraph_resource_action.update[0]
    values = {
      id = "upd-00000000-0000-0000-0000-000000000002"
      output = {
        request_id = "upd-00000000-0000-0000-0000-000000000002"
        state      = "delivered"
        status     = "Delivered"
      }
    }
  }
}

run "the_upgrade_keeps_the_stored_update_input_and_sends_no_second_admin_update" {
  state_key = "upgrade"
  command   = apply

  variables {
    schedule_update = {
      startDateTime = "2026-11-01T00:00:00Z"
      expiration = {
        type     = "afterDuration"
        duration = "P90D"
      }
    }
  }

  assert {
    condition     = jsonencode(terraform_data.update_input.input) == jsonencode({ start_date_time = "2026-11-01T00:00:00Z", expiration = { type = "afterDuration", end_date_time = null, duration = "P90D" } })
    error_message = "The stored update input must keep the v4.0.0 shape."
  }

  # A replacement would give the action the mock default ID instead of the saved one.
  assert {
    condition     = msgraph_resource_action.update[0].id == "upd-00000000-0000-0000-0000-000000000002"
    error_message = "The upgrade must not replace the update action, which would send another adminUpdate."
  }
}
