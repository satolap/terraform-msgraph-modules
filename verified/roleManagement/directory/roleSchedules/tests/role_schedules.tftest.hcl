# Mocking providers does not suppress destroy provisioners. Disable that hook.
mock_provider "null" {}
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-00000000-0000-0000-0000-000000000001"
      output = {
        request_id = "req-00000000-0000-0000-0000-000000000001"
        status     = "Provisioned"
      }
    }
  }

  # By default every read finds nothing: no role by display name and no
  # schedule yet. Individual runs override this where needed.
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        roles     = []
        schedules = []
      }
    }
  }
}

variables {
  enable_destroy_cleanup = false
  assignment_type        = "eligible"
  principalId            = "11111111-1111-1111-1111-111111111111"
  roleDefinitionId       = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"

  # keep unit tests fast and tolerant of the empty mock read
  verification_delay_seconds    = 0
  fail_on_verification_mismatch = false
}

run "submits_eligible_admin_assign_request" {
  command = apply

  assert {
    condition     = msgraph_resource_action.assign.resource_url == "roleManagement/directory/roleEligibilityScheduleRequests"
    error_message = "An eligible assignment must POST to roleEligibilityScheduleRequests."
  }

  assert {
    condition     = msgraph_resource_action.assign.method == "POST"
    error_message = "The request must be a POST."
  }

  assert {
    condition     = msgraph_resource_action.assign.body.action == "adminAssign"
    error_message = "The action must be adminAssign."
  }

  assert {
    condition     = msgraph_resource_action.assign.body.principalId == "11111111-1111-1111-1111-111111111111" && msgraph_resource_action.assign.body.roleDefinitionId == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "The request must name the principal and the role definition."
  }

  assert {
    condition     = msgraph_resource_action.assign.body.directoryScopeId == "/" && msgraph_resource_action.assign.body.justification == "Managed by Terraform"
    error_message = "The scope and justification must default to \"/\" and \"Managed by Terraform\"."
  }

  assert {
    condition     = jsonencode(msgraph_resource_action.assign.body.scheduleInfo) == jsonencode({ expiration = { type = "noExpiration" } })
    error_message = "By default the schedule must be permanent and carry no startDateTime."
  }

  assert {
    condition     = data.msgraph_resource.verify.url == "roleManagement/directory/roleEligibilitySchedules"
    error_message = "An eligible assignment must be verified against roleEligibilitySchedules."
  }

  assert {
    condition     = data.msgraph_resource.verify.query_parameters["$filter"][0] == "principalId eq '11111111-1111-1111-1111-111111111111' and roleDefinitionId eq 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa' and directoryScopeId eq '/'"
    error_message = "Verification must filter by principal, role and scope."
  }

  assert {
    condition     = output.request_id == "req-00000000-0000-0000-0000-000000000001" && output.status == "Provisioned"
    error_message = "request_id and status must come from the request response."
  }

  assert {
    condition     = output.verified == false && output.schedule_id == null
    error_message = "An empty verification read must surface verified=false and a null schedule_id."
  }

  assert {
    condition     = output.role_definition_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.directory_scope_id == "/"
    error_message = "The role and scope outputs must echo the inputs."
  }
}

run "submits_active_admin_assign_request" {
  command = apply

  variables {
    assignment_type = "active"
  }

  assert {
    condition     = msgraph_resource_action.assign.resource_url == "roleManagement/directory/roleAssignmentScheduleRequests"
    error_message = "An active assignment must POST to roleAssignmentScheduleRequests."
  }

  assert {
    condition     = msgraph_resource_action.assign.body.action == "adminAssign"
    error_message = "The action must be adminAssign."
  }

  assert {
    condition     = data.msgraph_resource.verify.url == "roleManagement/directory/roleAssignmentSchedules"
    error_message = "An active assignment must be verified against roleAssignmentSchedules."
  }
}

run "uses_the_api_version_on_every_request" {
  command = plan

  variables {
    api_version = "beta"
  }

  assert {
    condition     = msgraph_resource_action.assign.api_version == "beta" && data.msgraph_resource.verify.api_version == "beta"
    error_message = "api_version must reach the request and the verification read."
  }
}

run "sends_the_start_time_when_set" {
  command = plan

  variables {
    start_date_time = "2026-11-01T00:00:00Z"
  }

  assert {
    condition     = msgraph_resource_action.assign.body.scheduleInfo.startDateTime == "2026-11-01T00:00:00Z"
    error_message = "A start_date_time must be sent as scheduleInfo.startDateTime."
  }
}

run "expires_after_a_date" {
  command = plan

  variables {
    expiration_type = "afterDateTime"
    end_date_time   = "2027-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource_action.assign.body.scheduleInfo.expiration) == jsonencode({ type = "afterDateTime", endDateTime = "2027-01-01T00:00:00Z" })
    error_message = "afterDateTime must send endDateTime and no duration."
  }
}

run "expires_after_a_duration" {
  command = plan

  variables {
    assignment_type = "active"
    expiration_type = "afterDuration"
    duration        = "PT8H"
  }

  assert {
    condition     = jsonencode(msgraph_resource_action.assign.body.scheduleInfo.expiration) == jsonencode({ type = "afterDuration", duration = "PT8H" })
    error_message = "afterDuration must send duration and no endDateTime."
  }
}

run "accepts_day_durations" {
  command = plan

  variables {
    expiration_type = "afterDuration"
    duration        = "P30D"
  }

  assert {
    condition     = msgraph_resource_action.assign.body.scheduleInfo.expiration.duration == "P30D"
    error_message = "A duration in days must be accepted."
  }
}

run "refuses_after_date_time_without_end" {
  command = plan

  variables {
    expiration_type = "afterDateTime"
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "refuses_end_date_time_without_after_date_time" {
  command = plan

  variables {
    end_date_time = "2027-01-01T00:00:00Z"
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "refuses_after_duration_without_duration" {
  command = plan

  variables {
    expiration_type = "afterDuration"
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "refuses_duration_without_after_duration" {
  command = plan

  variables {
    duration = "PT8H"
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "rejects_unknown_expiration_type" {
  command = plan

  variables {
    expiration_type = "never"
  }

  expect_failures = [var.expiration_type]
}

run "rejects_malformed_durations" {
  command = plan

  variables {
    expiration_type = "afterDuration"
    duration        = "8H"
  }

  expect_failures = [var.duration]
}

run "rejects_a_duration_without_components" {
  command = plan

  variables {
    expiration_type = "afterDuration"
    duration        = "PT"
  }

  expect_failures = [var.duration]
}

run "rejects_a_bare_period_designator" {
  command = plan

  variables {
    expiration_type = "afterDuration"
    duration        = "P"
  }

  expect_failures = [var.duration]
}

run "rejects_month_durations" {
  command = plan

  variables {
    expiration_type = "afterDuration"
    duration        = "P1M"
  }

  expect_failures = [var.duration]
}

run "rejects_a_malformed_start_time" {
  command = plan

  variables {
    start_date_time = "tomorrow"
  }

  expect_failures = [var.start_date_time]
}

run "rejects_a_malformed_end_time" {
  command = plan

  variables {
    expiration_type = "afterDateTime"
    end_date_time   = "2027-01-01"
  }

  expect_failures = [var.end_date_time]
}

run "rejects_unknown_assignment_type" {
  command = plan

  variables {
    assignment_type = "permanent"
  }

  expect_failures = [var.assignment_type]
}

run "rejects_a_principal_that_is_not_a_guid" {
  command = plan

  variables {
    principalId = "alice@contoso.com"
  }

  expect_failures = [var.principalId]
}

run "rejects_a_role_definition_that_is_not_a_guid" {
  command = plan

  variables {
    roleDefinitionId = "Global Administrator"
  }

  expect_failures = [var.roleDefinitionId]
}

run "rejects_an_empty_justification" {
  command = plan

  variables {
    justification = "  "
  }

  expect_failures = [var.justification]
}

run "accepts_an_administrative_unit_scope" {
  command = plan

  variables {
    directoryScopeId = "/administrativeUnits/22222222-2222-2222-2222-222222222222"
  }

  assert {
    condition     = msgraph_resource_action.assign.body.directoryScopeId == "/administrativeUnits/22222222-2222-2222-2222-222222222222"
    error_message = "An administrative unit scope must be sent as given."
  }

  assert {
    condition     = strcontains(data.msgraph_resource.verify.query_parameters["$filter"][0], "directoryScopeId eq '/administrativeUnits/22222222-2222-2222-2222-222222222222'")
    error_message = "Verification must filter on the administrative unit scope."
  }
}

run "accepts_a_directory_object_scope" {
  command = plan

  variables {
    directoryScopeId = "/33333333-3333-3333-3333-333333333333"
  }

  assert {
    condition     = msgraph_resource_action.assign.body.directoryScopeId == "/33333333-3333-3333-3333-333333333333"
    error_message = "A directory object scope must be sent as given."
  }
}

run "rejects_a_scope_without_a_leading_slash" {
  command = plan

  variables {
    directoryScopeId = "33333333-3333-3333-3333-333333333333"
  }

  expect_failures = [var.directoryScopeId]
}

run "rejects_an_unknown_scope_type" {
  command = plan

  variables {
    directoryScopeId = "/groups/33333333-3333-3333-3333-333333333333"
  }

  expect_failures = [var.directoryScopeId]
}

run "refuses_both_role_references" {
  command = plan

  variables {
    role_display_name = "Global Reader"
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "refuses_no_role_reference" {
  command = plan

  variables {
    roleDefinitionId = null
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "rejects_an_empty_role_display_name" {
  command = plan

  variables {
    roleDefinitionId  = null
    role_display_name = " "
  }

  expect_failures = [var.role_display_name]
}

run "looks_up_a_role_by_display_name" {
  command = plan

  variables {
    roleDefinitionId  = null
    role_display_name = "Director's Writer"
  }

  override_data {
    target = data.msgraph_resource.role[0]
    values = {
      output = {
        roles = [{ id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb", displayName = "Director's Writer" }]
      }
    }
  }

  assert {
    condition     = data.msgraph_resource.role[0].url == "roleManagement/directory/roleDefinitions"
    error_message = "The lookup must read roleDefinitions."
  }

  assert {
    condition     = data.msgraph_resource.role[0].query_parameters["$filter"][0] == "displayName eq 'Director''s Writer'"
    error_message = "The lookup must filter on the display name with apostrophes escaped."
  }

  assert {
    condition     = msgraph_resource_action.assign.body.roleDefinitionId == "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
    error_message = "The request must carry the resolved role definition ID."
  }

  assert {
    condition     = output.role_definition_id == "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
    error_message = "The role_definition_id output must show the resolved role."
  }
}

run "does_not_look_up_a_role_given_by_id" {
  command = plan

  assert {
    condition     = length(data.msgraph_resource.role) == 0
    error_message = "A role given by ID needs no lookup."
  }
}

run "refuses_a_display_name_without_a_match" {
  command = plan

  variables {
    roleDefinitionId  = null
    role_display_name = "No Such Role"
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "refuses_a_display_name_with_two_matches" {
  command = plan

  variables {
    roleDefinitionId  = null
    role_display_name = "Global Reader"
  }

  override_data {
    target = data.msgraph_resource.role[0]
    values = {
      output = {
        roles = [{ id = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" }, { id = "00000000-0000-0000-0000-0000000000ff" }]
      }
    }
  }

  expect_failures = [msgraph_resource_action.assign]
}

run "captures_the_schedule_when_found" {
  command = apply

  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        schedules = [
          {
            id               = "sched-00000000-0000-0000-0000-0000000000aa"
            principalId      = "11111111-1111-1111-1111-111111111111"
            roleDefinitionId = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
            directoryScopeId = "/"
            memberType       = "Direct"
            status           = "Provisioned"
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == true && output.schedule_id == "sched-00000000-0000-0000-0000-0000000000aa"
    error_message = "A matching schedule must set verified and schedule_id, ignoring letter case of the IDs."
  }
}

run "ignores_schedules_of_other_scopes" {
  command = apply

  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        schedules = [
          {
            id               = "other-scope"
            principalId      = "11111111-1111-1111-1111-111111111111"
            roleDefinitionId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            directoryScopeId = "/administrativeUnits/22222222-2222-2222-2222-222222222222"
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == false
    error_message = "A schedule at another scope is not this assignment."
  }
}

run "ignores_an_activated_schedule_for_an_active_assignment" {
  command = apply

  variables {
    assignment_type = "active"
  }

  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        schedules = [
          {
            id               = "activated"
            principalId      = "11111111-1111-1111-1111-111111111111"
            roleDefinitionId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            directoryScopeId = "/"
            memberType       = "Direct"
            assignmentType   = "Activated"
          },
          {
            id               = "assigned"
            principalId      = "11111111-1111-1111-1111-111111111111"
            roleDefinitionId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            directoryScopeId = "/"
            memberType       = "Direct"
            assignmentType   = "Assigned"
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == true && output.schedule_id == "assigned"
    error_message = "Only the assigned schedule is this assignment, not an activation of an eligibility."
  }
}

run "ignores_a_schedule_inherited_through_a_group" {
  command = apply

  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        schedules = [
          {
            id               = "via-group"
            principalId      = "11111111-1111-1111-1111-111111111111"
            roleDefinitionId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            directoryScopeId = "/"
            memberType       = "Group"
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == false
    error_message = "A schedule inherited through a group is not this assignment."
  }
}

# A changed justification replaces the request and the sleep, so the read is deferred to apply and the
# gate result is unknown at plan on every Terraform version; the failure is raised at apply.
run "fails_the_gate_when_no_schedule_is_found" {
  command = apply

  variables {
    fail_on_verification_mismatch = true
    justification                 = "gate: none found"
  }

  override_data {
    target = data.msgraph_resource.verify
    values = { output = { schedules = [] } }
  }

  expect_failures = [terraform_data.verification_gate]
}

# A changed justification replaces the request and the sleep, so the read is deferred to apply and the
# gate result is unknown at plan on every Terraform version; the failure is raised at apply.
run "fails_the_gate_on_ambiguous_schedules" {
  command = apply

  variables {
    fail_on_verification_mismatch = true
    justification                 = "gate: ambiguous"
  }

  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        schedules = [
          { id = "first", principalId = "11111111-1111-1111-1111-111111111111", roleDefinitionId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", directoryScopeId = "/" },
          { id = "second", principalId = "11111111-1111-1111-1111-111111111111", roleDefinitionId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", directoryScopeId = "/" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "passes_the_gate_when_the_schedule_is_found" {
  command = apply

  variables {
    fail_on_verification_mismatch = true
  }

  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        schedules = [
          { id = "found", principalId = "11111111-1111-1111-1111-111111111111", roleDefinitionId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", directoryScopeId = "/" },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == true
    error_message = "A found schedule must pass the gate."
  }
}

# A schedule that has not started may not be listed yet.
run "does_not_fail_the_gate_for_a_future_start" {
  command = apply

  variables {
    fail_on_verification_mismatch = true
    start_date_time               = "2999-01-01T00:00:00Z"
  }

  assert {
    condition     = output.verified == false
    error_message = "The schedule is not listed in this test; only the gate must let it pass."
  }
}

# Applied, not planned: the changed start time defers the read, so the gate fails at apply.
run "fails_the_gate_for_a_start_in_the_past" {
  command = apply

  variables {
    fail_on_verification_mismatch = true
    start_date_time               = "2000-01-01T00:00:00Z"
  }

  expect_failures = [terraform_data.verification_gate]
}

# Every input that shapes the request replaces the request, the sleep and the
# hook, so the old assignment is removed before the new one is added.
run "records_every_request_input" {
  command = plan

  variables {
    justification = "Break glass"
  }

  assert {
    condition = jsonencode(terraform_data.assignment.input) == jsonencode({
      api_version        = "v1.0"
      assignment_type    = "eligible"
      directory_scope_id = "/"
      duration           = null
      end_date_time      = null
      expiration_type    = "noExpiration"
      justification      = "Break glass"
      principal_id       = "11111111-1111-1111-1111-111111111111"
      role_definition_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      start_date_time    = null
    })
    error_message = "The replace trigger must hold every input of the request."
  }
}

run "a_new_justification_waits_again_before_verifying" {
  command = apply

  variables {
    justification = "Break glass"
  }

  override_resource {
    target = time_sleep.wait_for_delivery
    values = {
      id = "sleep-after-new-justification"
    }
  }

  assert {
    condition     = time_sleep.wait_for_delivery.id == "sleep-after-new-justification"
    error_message = "A changed request must replace the sleep, so that verification waits again."
  }
}
