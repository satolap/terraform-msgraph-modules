# The grant lifecycle in file order, sharing one state: a request that waits for
# approval, a timeout, recovery by re-reading the same request, a repeated apply
# that changes nothing, and adminUpdate. Mocked providers: the read-backs are
# overrides, so these runs prove how the module classifies what Graph would say,
# not what Graph does.
# Mocking providers does not suppress destroy provisioners. Disable that hook.
mock_provider "null" {}
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-00000000-0000-0000-0000-000000000001"
      output = {
        request_id = "req-00000000-0000-0000-0000-000000000001"
        state      = "submitted"
        status     = "Accepted"
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
}

run "an_accepted_request_waiting_for_approval_is_not_a_delivered_assignment" {
  command = apply

  variables {
    require_delivery = false
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "pendingApproval"
        status = "WaitingForApproval"
      }
    }
  }

  assert {
    condition     = output.request_id == "req-00000000-0000-0000-0000-000000000001"
    error_message = "The accepted request's ID must be reported."
  }

  assert {
    condition     = output.request_state == "pendingApproval" && output.request_phase == "pending"
    error_message = "A request waiting for approval must be pending."
  }

  assert {
    condition     = output.assignment_id == null && output.assignment_state == null
    error_message = "No assignment ID may be taken from a request ID or invented while the request is pending."
  }

  assert {
    condition     = output.delivered == false
    error_message = "A pending request must not report delivered."
  }
}

run "a_request_still_pending_after_the_wait_fails_when_delivery_is_required" {
  command = plan

  variables {
    require_delivery = true
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "pendingApproval"
        status = "WaitingForApproval"
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "an_accepted_request_that_is_delivered_but_not_yet_listed_fails_when_delivery_is_required" {
  command = plan

  variables {
    require_delivery = true
  }

  expect_failures = [terraform_data.verification_gate]
}

run "the_approved_request_resolves_to_the_delivered_assignment_on_the_next_apply" {
  command = apply

  variables {
    require_delivery = true
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "delivered"
        status = "Delivered"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
        assignments = [
          {
            id               = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            state            = "delivered"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
            schedule         = { expiration = { type = "noExpiration" } }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.request_id == "req-00000000-0000-0000-0000-000000000001"
    error_message = "Recovery must keep the request that was already sent, not send another."
  }

  assert {
    condition     = output.assignment_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.assignment_state == "delivered"
    error_message = "The delivered assignment ID must come from the assignments listing."
  }

  assert {
    condition     = output.request_phase == "delivered" && output.delivered == true && output.ambiguous == false
    error_message = "A delivered request with one delivered assignment must report delivered."
  }

  assert {
    condition     = output.assignment_schedule_json == jsonencode({ expiration = { type = "noExpiration" } })
    error_message = "The assignment's schedule must be reported as Graph returned it."
  }
}

run "a_repeated_apply_is_a_no_op_that_keeps_the_same_ids" {
  command = apply

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "delivered"
        status = "Delivered"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
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

  assert {
    condition     = output.request_id == "req-00000000-0000-0000-0000-000000000001" && output.assignment_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.delivered == true
    error_message = "A repeated apply must keep the request and the assignment and change nothing."
  }
}

run "another_assignment_of_the_same_subject_is_never_claimed" {
  command = apply

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
        assignments = [
          {
            id               = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            state            = "delivered"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
          {
            id               = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
            state            = "delivered"
            target           = { objectId = "44444444-4444-4444-4444-444444444444" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
          {
            id               = "cccccccc-cccc-4ccc-8ccc-cccccccccccc"
            state            = "delivered"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "55555555-5555-5555-5555-555555555555" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.assignment_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.ambiguous == false
    error_message = "Only the assignment of this subject, policy and package may be resolved; unrelated assignments must be ignored."
  }
}

run "an_expired_assignment_of_an_earlier_grant_is_ignored_next_to_the_live_one" {
  command = apply

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
        assignments = [
          {
            id               = "dddddddd-dddd-4ddd-8ddd-dddddddddddd"
            state            = "expired"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
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

  assert {
    condition     = output.assignment_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.assignment_state == "delivered" && output.ambiguous == false
    error_message = "An expired assignment is history and must not make the live one ambiguous."
  }
}

run "a_schedule_update_sends_admin_update_for_the_resolved_assignment" {
  command = apply

  variables {
    schedule_update = {
      expiration = {
        type     = "afterDuration"
        duration = "P90D"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "delivered"
        status = "Delivered"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
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

  override_resource {
    target = msgraph_resource_action.update[0]
    values = {
      id = "upd-00000000-0000-0000-0000-000000000002"
      output = {
        request_id = "upd-00000000-0000-0000-0000-000000000002"
        state      = "delivering"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.update_request[0]
    values = {
      output = {
        state  = "delivered"
        status = "Delivered"
      }
    }
  }

  assert {
    condition     = msgraph_resource_action.update[0].body.requestType == "adminUpdate"
    error_message = "The update must be an adminUpdate request."
  }

  assert {
    condition     = msgraph_resource_action.update[0].body.assignment.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "adminUpdate must name the resolved assignment ID, not a request ID."
  }

  assert {
    condition     = jsonencode(msgraph_resource_action.update[0].body.schedule) == jsonencode({ expiration = { duration = "P90D", type = "afterDuration" } })
    error_message = "adminUpdate must send the new schedule."
  }

  assert {
    condition     = output.update_request_id == "upd-00000000-0000-0000-0000-000000000002" && output.update_request_phase == "delivered"
    error_message = "The update request and its phase must be reported separately from the first request."
  }

  assert {
    condition     = output.request_id == "req-00000000-0000-0000-0000-000000000001"
    error_message = "An update must not replace or re-send the original request."
  }
}

run "an_update_that_waits_for_approval_fails_when_delivery_is_required" {
  command = apply

  variables {
    schedule_update = {
      expiration = {
        type          = "afterDateTime"
        end_date_time = "2027-06-01T00:00:00Z"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "delivered"
        status = "Delivered"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
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

  override_data {
    target = data.msgraph_resource.update_request[0]
    values = {
      output = {
        state  = "pendingApproval"
        status = "WaitingForApproval"
      }
    }
  }

  expect_failures = [terraform_data.update_gate[0]]
}

run "an_update_is_refused_while_no_assignment_is_resolved" {
  command = plan

  variables {
    require_delivery = false
    schedule_update = {
      expiration = {
        type     = "afterDuration"
        duration = "P10D"
      }
    }
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "pendingApproval"
        status = "WaitingForApproval"
      }
    }
  }

  expect_failures = [msgraph_resource_action.update[0]]
}
