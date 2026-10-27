# Offline mock tests. They prove the request contract and the correlation rules
# against supplied snapshots; they do not establish live Graph or PIM behaviour.
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-1"
      output = {
        request_id         = "req-1"
        status             = "PendingProvisioning"
        target_schedule_id = null
      }
    }
  }

  # By default every read finds nothing: no schedule and no instance yet.
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

run "submits_one_explicit_admin_assign_for_member" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  assert {
    condition     = msgraph_resource_action.request.resource_url == "identityGovernance/privilegedAccess/group/eligibilityScheduleRequests" && msgraph_resource_action.request.method == "POST" && msgraph_resource_action.request.api_version == "v1.0"
    error_message = "The request must POST to the eligibilityScheduleRequests collection on v1.0."
  }

  assert {
    condition = jsonencode(msgraph_resource_action.request.body) == jsonencode({
      action        = "adminAssign"
      principalId   = "11111111-1111-1111-1111-111111111111"
      groupId       = "22222222-2222-2222-2222-222222222222"
      accessId      = "member"
      justification = "Offline contract test"
      scheduleInfo = {
        startDateTime = "2099-01-01T00:00:00Z"
        expiration = {
          type        = "afterDateTime"
          endDateTime = "2099-01-01T08:00:00Z"
        }
      }
    })
    error_message = "The body must be exactly one adminAssign with explicit identity and one bounded window, with no recurrence."
  }

  assert {
    condition     = data.msgraph_resource.schedule.url == "identityGovernance/privilegedAccess/group/eligibilitySchedules" && data.msgraph_resource.instance.url == "identityGovernance/privilegedAccess/group/eligibilityScheduleInstances"
    error_message = "Results must be read from the eligibility schedule and instance collections only."
  }

  assert {
    condition     = data.msgraph_resource.schedule.query_parameters["$filter"][0] == "principalId eq '11111111-1111-1111-1111-111111111111' and groupId eq '22222222-2222-2222-2222-222222222222' and accessId eq 'member'"
    error_message = "The schedule read must filter by principal, group and access."
  }

  assert {
    condition     = output.request_id == "req-1" && output.request_status == "PendingProvisioning" && output.state == "request_accepted_only" && output.schedule_id == null && output.instance_id == null
    error_message = "An accepted request with no schedule or instance must stay request_accepted_only."
  }

  assert {
    condition     = output.expires_at == "2099-01-01T08:00:00Z"
    error_message = "expires_at must echo the requested end."
  }
}

run "submits_owner_access_distinctly" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    access_id = "owner"
  }

  assert {
    condition     = msgraph_resource_action.request.body.accessId == "owner" && msgraph_resource_action.request.body.action == "adminAssign"
    error_message = "owner access must be sent explicitly as accessId owner."
  }

  assert {
    condition     = strcontains(data.msgraph_resource.schedule.query_parameters["$filter"][0], "accessId eq 'owner'")
    error_message = "The read must filter on owner."
  }
}

run "identity_and_window_but_not_justification_are_the_grant_identity" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  assert {
    condition = jsonencode(terraform_data.grant.input) == jsonencode({
      access_id       = "member"
      end_date_time   = "2099-01-01T08:00:00Z"
      group_id        = "22222222-2222-2222-2222-222222222222"
      principal_id    = "11111111-1111-1111-1111-111111111111"
      start_date_time = "2099-01-01T00:00:00Z"
    })
    error_message = "Replacement must depend on identity and window only, never on the justification text."
  }
}

run "no_unsupported_surface_is_reachable" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  assert {
    condition     = msgraph_resource_action.request.body.action == "adminAssign" && !contains(keys(msgraph_resource_action.request.body), "ticketInfo") && !contains(keys(msgraph_resource_action.request.body.scheduleInfo), "recurrence")
    error_message = "Only adminAssign without recurrence or extra properties is offered."
  }
}

run "correlates_schedule_and_instance_for_request" {
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
          id           = "sched-1"
          createdUsing = "req-1"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          memberType   = "direct"
          status       = "Provisioned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:00Z"
            recurrence    = null
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.instance
    values = {
      output = {
        instances = [{
          id                    = "inst-1"
          eligibilityScheduleId = "sched-1"
          principalId           = "11111111-1111-1111-1111-111111111111"
          groupId               = "22222222-2222-2222-2222-222222222222"
          accessId              = "member"
          memberType            = "direct"

        }]
      }
    }
  }

  assert {
    condition     = output.schedule_id == "sched-1" && output.instance_id == "inst-1" && output.state == "instance_observed"
    error_message = "A schedule created by this request and its linked instance must be correlated."
  }
}

run "equivalent_timestamp_spelling_still_correlates" {
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
          id           = "sched-1"
          createdUsing = "req-1"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          memberType   = "direct"
          status       = "Provisioned"
          scheduleInfo = {
            startDateTime = "2099-01-01T02:00:00+02:00"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T10:00:00+02:00" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.schedule_id == "sched-1" && output.state == "schedule_only"
    error_message = "A different spelling of the same instants is the same window; with no instance the state is schedule_only."
  }
}

run "schedule_without_instance_is_not_effective_evidence" {
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
          id           = "sched-1"
          createdUsing = "req-1"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          memberType   = "direct"
          status       = "Provisioned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:00Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.state == "schedule_only" && output.instance_id == null
    error_message = "A schedule alone must never count as an observed instance."
  }
}

run "refuses_schedule_of_another_request" {
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
          id           = "sched-9"
          createdUsing = "req-other"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          memberType   = "direct"
          status       = "Provisioned"
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
    error_message = "An identity-only match from another request must never be adopted."
  }
}

run "refuses_group_derived_recurring_and_other_window_schedules" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.schedule
    values = {
      output = {
        schedules = [
          {
            id           = "sched-g"
            createdUsing = "req-1"
            principalId  = "11111111-1111-1111-1111-111111111111"
            groupId      = "22222222-2222-2222-2222-222222222222"
            accessId     = "member"
            memberType   = "group"
            status       = "Provisioned"
            scheduleInfo = {
              startDateTime = "2099-01-01T00:00:00Z"
              expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
            }
          },
          {
            id           = "sched-r"
            createdUsing = "req-1"
            principalId  = "11111111-1111-1111-1111-111111111111"
            groupId      = "22222222-2222-2222-2222-222222222222"
            accessId     = "member"
            memberType   = "direct"
            status       = "Provisioned"
            scheduleInfo = {
              startDateTime = "2099-01-01T00:00:00Z"
              recurrence    = { pattern = { type = "daily", interval = 1 } }
              expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
            }
          },
          {
            id           = "sched-w"
            createdUsing = "req-1"
            principalId  = "11111111-1111-1111-1111-111111111111"
            groupId      = "22222222-2222-2222-2222-222222222222"
            accessId     = "member"
            memberType   = "direct"
            status       = "Provisioned"
            scheduleInfo = {
              startDateTime = "2099-01-01T00:00:00Z"
              expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T09:00:00Z" }
            }
          },
          {
            id           = "sched-x"
            createdUsing = "req-1"
            principalId  = "11111111-1111-1111-1111-111111111111"
            groupId      = "33333333-3333-3333-3333-333333333333"
            accessId     = "member"
            memberType   = "direct"
            status       = "Provisioned"
            scheduleInfo = {
              startDateTime = "2099-01-01T00:00:00Z"
              expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
            }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.schedule_id == null && output.state == "request_accepted_only"
    error_message = "Group-derived, recurring, different-window and different-group schedules must all be refused."
  }
}

run "two_matching_schedules_are_ambiguous" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.schedule
    values = {
      output = {
        schedules = [
          for id in ["sched-1", "sched-2"] : {
            id           = id
            createdUsing = "req-1"
            principalId  = "11111111-1111-1111-1111-111111111111"
            groupId      = "22222222-2222-2222-2222-222222222222"
            accessId     = "member"
            memberType   = "direct"
            status       = "Provisioned"
            scheduleInfo = {
              startDateTime = "2099-01-01T00:00:00Z"
              expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
            }
          }
        ]
      }
    }
  }

  assert {
    condition     = output.schedule_id == null && output.state == "request_accepted_only"
    error_message = "More than one correlated schedule must fail closed."
  }
}

run "refuses_instance_linked_to_another_schedule_or_indirect" {
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
          id           = "sched-1"
          createdUsing = "req-1"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          memberType   = "direct"
          status       = "Provisioned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:00Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.instance
    values = {
      output = {
        instances = [
          {
            id                    = "inst-other"
            eligibilityScheduleId = "sched-other"
            principalId           = "11111111-1111-1111-1111-111111111111"
            groupId               = "22222222-2222-2222-2222-222222222222"
            accessId              = "member"
            memberType            = "direct"

          },
          {
            id                    = "inst-group"
            eligibilityScheduleId = "sched-1"
            principalId           = "11111111-1111-1111-1111-111111111111"
            groupId               = "22222222-2222-2222-2222-222222222222"
            accessId              = "member"
            memberType            = "group"

          },
        ]
      }
    }
  }

  assert {
    condition     = output.schedule_id == "sched-1" && output.instance_id == null && output.state == "schedule_only"
    error_message = "An instance of another schedule, or an indirect one, is not evidence for this grant."
  }
}

run "gate_demands_schedule_and_instance_while_window_is_open" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    fail_on_verification_mismatch = true
    start_date_time               = timeadd(timestamp(), "-1h")
    end_date_time                 = timeadd(timestamp(), "1h")
  }

  expect_failures = [terraform_data.verification_gate]
}

run "gate_tolerates_future_and_expired_windows" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    fail_on_verification_mismatch = true
    start_date_time               = "2020-01-01T00:00:00Z"
    end_date_time                 = "2020-01-01T08:00:00Z"
  }

  assert {
    condition     = output.state == "expired"
    error_message = "An expired window must not fail later plans and must report expired."
  }
}

run "rejects_unbounded_or_oversized_windows" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    end_date_time = "2099-01-02T00:00:01Z"
  }

  expect_failures = [var.end_date_time]
}

run "rejects_end_not_after_start" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    end_date_time = "2099-01-01T00:00:00Z"
  }

  expect_failures = [var.end_date_time]
}

run "rejects_missing_or_unknown_access" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    access_id = "admin"
  }

  expect_failures = [var.access_id]
}

run "rejects_blank_justification" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    justification = "  "
  }

  expect_failures = [var.justification]
}

run "rejects_non_canonical_identifiers" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    principal_id = "11111111-1111-1111-1111-11111111111G"
    group_id     = "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"
  }

  expect_failures = [var.principal_id, var.group_id]
}

run "future_window_never_fails_the_gate" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    fail_on_verification_mismatch = true
    start_date_time               = timeadd(timestamp(), "1h")
    end_date_time                 = timeadd(timestamp(), "2h")
  }

  assert {
    condition     = output.state == "request_accepted_only"
    error_message = "A window that has not started must neither fail the gate nor claim more than acceptance."
  }
}

run "tolerates_a_small_difference_in_stored_times" {
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
          id           = "sched-1"
          createdUsing = "req-1"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          memberType   = "direct"
          status       = "Provisioned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:00:30Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T07:59:30Z" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.schedule_id == "sched-1"
    error_message = "A 30 second difference in stored times is tolerated."
  }
}

run "refuses_a_five_minute_difference" {
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
          id           = "sched-1"
          createdUsing = "req-1"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          memberType   = "direct"
          status       = "Provisioned"
          scheduleInfo = {
            startDateTime = "2099-01-01T00:05:00Z"
            expiration    = { type = "afterDateTime", endDateTime = "2099-01-01T08:00:00Z" }
          }
        }]
      }
    }
  }

  assert {
    condition     = output.schedule_id == null
    error_message = "A five minute difference is a different window."
  }
}

run "missing_member_type_is_not_direct" {
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
          id           = "sched-1"
          createdUsing = "req-1"
          principalId  = "11111111-1111-1111-1111-111111111111"
          groupId      = "22222222-2222-2222-2222-222222222222"
          accessId     = "member"
          status       = "Provisioned"
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
    error_message = "A schedule without memberType must not be treated as direct."
  }
}

run "rejects_a_window_shorter_than_five_minutes" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    end_date_time = "2099-01-01T00:04:59Z"
  }

  expect_failures = [var.end_date_time]
}

run "accepts_a_window_of_exactly_five_minutes" {
  command = plan

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  variables {
    end_date_time = "2099-01-01T00:05:00Z"
  }

  assert {
    condition     = msgraph_resource_action.request.body.scheduleInfo.expiration.endDateTime == "2099-01-01T00:05:00Z"
    error_message = "PIM's five-minute minimum is inclusive: a window of exactly five minutes must be accepted."
  }
}
