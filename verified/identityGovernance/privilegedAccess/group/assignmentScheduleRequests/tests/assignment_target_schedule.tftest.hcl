# targetScheduleId correlation. The mocked response reports the target schedule.
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-1"
      output = {
        request_id         = "req-1"
        status             = "Provisioned"
        target_schedule_id = "sched-1"
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
  principalId                   = "11111111-1111-1111-1111-111111111111"
  groupId                       = "22222222-2222-2222-2222-222222222222"
  accessId                      = "owner"
  justification                 = "Offline contract test"
  start_date_time               = "2099-01-01T00:00:00Z"
  end_date_time                 = "2099-01-01T08:00:00Z"
  verification_delay_seconds    = 0
  fail_on_verification_mismatch = false
}

run "schedule_named_by_target_schedule_id_alone_correlates" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.schedule
    values = {
      output = {
        schedules = [{
          id             = "sched-1"
          principalId    = "11111111-1111-1111-1111-111111111111"
          groupId        = "22222222-2222-2222-2222-222222222222"
          accessId       = "owner"
          memberType     = "direct"
          status         = "Provisioned"
          assignmentType = "assigned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:00Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.target_schedule_id == "sched-1" && output.schedule_id == "sched-1" && output.state == "schedule_only"
    error_message = "A schedule whose id is the reported targetScheduleId must correlate."
  }
}

run "created_using_that_disagrees_with_the_request_is_refused" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.schedule
    values = {
      output = {
        schedules = [{
          id             = "sched-1"
          createdUsing   = "req-other"
          principalId    = "11111111-1111-1111-1111-111111111111"
          groupId        = "22222222-2222-2222-2222-222222222222"
          accessId       = "owner"
          memberType     = "direct"
          status         = "Provisioned"
          assignmentType = "assigned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:00Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.schedule_id == null && output.state == "request_accepted_only"
    error_message = "createdUsing naming another request must override a matching targetScheduleId."
  }
}

run "schedule_with_other_id_than_target_is_refused" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.schedule
    values = {
      output = {
        schedules = [{
          id             = "sched-2"
          createdUsing   = "req-1"
          principalId    = "11111111-1111-1111-1111-111111111111"
          groupId        = "22222222-2222-2222-2222-222222222222"
          accessId       = "owner"
          memberType     = "direct"
          status         = "Provisioned"
          assignmentType = "assigned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:00Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.schedule_id == null
    error_message = "A schedule id that disagrees with the reported targetScheduleId must be refused."
  }
}

run "activated_schedule_is_not_a_direct_assignment" {
  command = apply

  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.schedule
    values = {
      output = {
        schedules = [{
          id             = "sched-1"
          createdUsing   = "req-1"
          principalId    = "11111111-1111-1111-1111-111111111111"
          groupId        = "22222222-2222-2222-2222-222222222222"
          accessId       = "owner"
          memberType     = "direct"
          assignmentType = "activated"
          status         = "Provisioned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:00Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.schedule_id == null
    error_message = "A schedule created by activating an eligibility must never be adopted as this assignment."
  }
}

