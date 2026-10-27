# Adoption: an existing assignment is taken over without sending any request.
# Mocked providers; the listing is an override.
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
  adopt_assignment_id        = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
  verification_delay_seconds = 0
}

run "adopts_an_existing_delivered_assignment_without_sending_a_request" {
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
        ]
      }
    }
  }

  assert {
    condition     = length(msgraph_resource_action.add) == 0 && length(data.msgraph_resource.request) == 0
    error_message = "Adoption must send no request and read none."
  }

  assert {
    condition     = output.request_id == null && output.request_state == null && output.request_phase == "adopted"
    error_message = "An adoption has no request."
  }

  assert {
    condition     = output.assignment_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.assignment_state == "delivered" && output.delivered == true
    error_message = "The adopted assignment must be resolved and reported delivered."
  }
}

run "adopting_an_assignment_of_another_subject_is_refused" {
  command = plan

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
        assignments = [
          {
            id               = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
            state            = "delivered"
            target           = { objectId = "44444444-4444-4444-4444-444444444444" }
            assignmentPolicy = { id = "33333333-3333-3333-3333-333333333333" }
            accessPackage    = { id = "22222222-2222-2222-2222-222222222222" }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verification_gate]
}

run "adopting_an_id_the_listing_does_not_contain_is_refused" {
  command = plan

  override_data {
    target = data.msgraph_resource.assignments
    values = {
      output = {
        assignments = [
          {
            id               = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
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

run "adopting_an_expired_assignment_fails" {
  command = plan

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

run "an_adopted_assignment_still_delivering_is_reported_when_delivery_is_not_required" {
  command = plan

  variables {
    require_delivery = false
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
    error_message = "A delivering adopted assignment must not report delivered."
  }
}

run "an_adopted_assignment_can_be_updated" {
  command = apply

  variables {
    schedule_update = {
      expiration = { type = "noExpiration" }
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
        state  = "delivered"
        status = "Delivered"
      }
    }
  }

  assert {
    condition     = msgraph_resource_action.update[0].body.assignment.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "adminUpdate of an adopted assignment must name its ID."
  }
}
