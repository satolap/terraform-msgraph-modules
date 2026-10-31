# A caller upgrading from v4.0.0 who keeps a snake_case nested name must fail at plan time:
# the object type would otherwise drop the name and fall back to its default.
# expect_failures does not read messages; each rejection run is paired with an accepting run
# of the same value without the legacy name, so the failure comes from the guard.
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
        state       = "delivered"
        status      = "Delivered"
        assignments = []
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
  require_delivery           = false
}

run "schedule_with_graph_names_is_accepted" {
  command = plan
  variables {
    schedule = {
      startDateTime = "2026-11-01T00:00:00Z"
      expiration    = { type = "afterDateTime", endDateTime = "2027-11-01T00:00:00Z" }
    }
  }
  assert {
    condition     = msgraph_resource_action.add[0].body.schedule.startDateTime == "2026-11-01T00:00:00Z" && msgraph_resource_action.add[0].body.schedule.expiration.endDateTime == "2027-11-01T00:00:00Z"
    error_message = "The Graph-named schedule must be sent."
  }
}

run "schedule_rejects_start_date_time" {
  command = plan
  variables {
    schedule = {
      start_date_time = "2026-11-01T00:00:00Z"
      expiration      = { type = "noExpiration" }
    }
  }
  expect_failures = [var.schedule]
}

run "schedule_rejects_expiration_end_date_time" {
  command = plan
  variables {
    schedule = {
      expiration = { type = "afterDateTime", end_date_time = "2027-11-01T00:00:00Z" }
    }
  }
  expect_failures = [var.schedule]
}

run "schedule_accepts_explicit_null_legacy_names" {
  command = plan
  variables {
    schedule = {
      startDateTime   = "2026-11-01T00:00:00Z"
      start_date_time = null
      expiration      = { type = "noExpiration", end_date_time = null }
    }
  }
}

run "schedule_update_with_graph_names_is_accepted" {
  command = plan
  variables {
    schedule_update = {
      startDateTime = "2026-11-01T00:00:00Z"
      expiration    = { type = "afterDateTime", endDateTime = "2027-11-01T00:00:00Z" }
    }
  }
}

run "schedule_update_rejects_start_date_time" {
  command = plan
  variables {
    schedule_update = {
      start_date_time = "2026-11-01T00:00:00Z"
      expiration      = { type = "noExpiration" }
    }
  }
  expect_failures = [var.schedule_update]
}

run "schedule_update_rejects_expiration_end_date_time" {
  command = plan
  variables {
    schedule_update = {
      expiration = { type = "afterDateTime", end_date_time = "2027-11-01T00:00:00Z" }
    }
  }
  expect_failures = [var.schedule_update]
}

run "schedule_update_accepts_explicit_null_legacy_names" {
  command = plan
  variables {
    schedule_update = {
      startDateTime   = "2026-11-01T00:00:00Z"
      start_date_time = null
      expiration      = { type = "noExpiration", end_date_time = null }
    }
  }
}
