# Requests and assignments that end badly, and read-backs that cannot be trusted.
# The first run applies against an empty state; the later runs plan against the
# request that run left in state, because the read-backs are known by then. Mocked
# providers: the read-backs are overrides, not Graph behavior.
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


run "a_denied_request_fails_the_apply_and_never_reads_as_delivered" {
  command = apply

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "denied"
        status = "Denied"
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

  expect_failures = [terraform_data.verification_gate]
}

run "a_denied_request_fails_even_when_delivery_is_not_required" {
  command = plan

  variables {
    require_delivery = false
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "denied"
        status = "Denied"
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "a_canceled_request_fails" {
  command = plan

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "canceled"
        status = "Canceled"
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "a_failed_delivery_fails" {
  command = plan

  variables {
    require_delivery = false
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "deliveryFailed"
        status = "DeliveryFailed"
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "a_partially_delivered_request_fails" {
  command = plan

  variables {
    require_delivery = false
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "partiallyDelivered"
        status = "PartiallyDelivered"
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "a_beta_spelling_of_a_state_is_unknown_and_not_delivered" {
  command = plan

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "Delivered"
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

  expect_failures = [terraform_data.verification_gate]
}

run "an_unknown_state_is_reported_without_failing_when_delivery_is_not_required" {
  command = plan

  variables {
    require_delivery = false
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "unknownFutureValue"
        status = "x"
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
    condition     = output.request_phase == "unknown" && output.delivered == false
    error_message = "An unrecognised request state must be unknown and never delivered."
  }
}

run "two_live_assignments_for_the_identity_are_ambiguous_and_resolve_to_nothing" {
  command = plan

  variables {
    require_delivery = false
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
          {
            id               = "eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee"
            state            = "delivered"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "a_delivered_request_whose_assignment_expired_fails" {
  command = plan

  variables {
    require_delivery = false
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
            state            = "expired"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "an_expired_assignment_is_reported_while_a_new_request_is_pending" {
  command = plan

  variables {
    require_delivery = false
  }

  override_data {
    target = data.msgraph_resource.request[0]
    values = {
      output = {
        state  = "pendingApproval"
        status = "x"
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
            state            = "expired"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.assignment_state == "expired" && output.request_phase == "pending" && output.delivered == false
    error_message = "A pending request next to an expired assignment must report both and not fail."
  }
}

run "an_assignment_in_flight_is_not_delivered" {
  command = plan

  variables {
    require_delivery = false
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
            state            = "delivering"
            target           = { objectId = "11111111-1111-1111-1111-111111111111" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.assignment_state == "delivering" && output.delivered == false
    error_message = "An assignment that is still delivering must not report delivered."
  }
}

run "a_delivered_assignment_for_another_policy_is_not_this_modules" {
  command = plan

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
            assignmentPolicy = { id = "55555555-5555-5555-5555-555555555555" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "an_unexpanded_listing_resolves_nothing_instead_of_guessing" {
  command = plan

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
        assignments = [{ id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", state = "delivered" }]
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}
