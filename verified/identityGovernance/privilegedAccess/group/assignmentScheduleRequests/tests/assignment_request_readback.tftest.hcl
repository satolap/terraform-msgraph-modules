# The POST response keeps the status the request had at creation. The module reads the
# request back through the collection filtered by id, so a later denial or failure is seen,
# and a request that is missing (not listed yet, or no longer) is never an error.
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-3"
      output = {
        request_id         = "req-3"
        status             = "PendingApproval"
        target_schedule_id = null
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        schedules = []
        instances = []
        requests  = []
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

run "a_request_denied_after_creation_fails_the_gate" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "Denied" }]
      }
    }
  }

  assert {
    condition     = data.msgraph_resource.request.query_parameters["$filter"][0] == "id eq 'req-3'"
    error_message = "The request must be read through the collection filtered by its id."
  }

  expect_failures = [terraform_data.verification_gate]
}

run "a_request_still_pending_after_the_read_back_is_not_rejected" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "PendingApproval" }]
      }
    }
  }

  assert {
    condition     = output.request_status == "PendingApproval" && output.state == "request_accepted_only"
    error_message = "A pending request is accepted but not rejected."
  }
}

run "a_request_that_is_not_listed_at_creation_is_not_an_error" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = []
      }
    }
  }

  assert {
    condition     = output.request_status == "PendingApproval" && output.state == "request_accepted_only"
    error_message = "A request missing from the read-back falls back to the creation status and does not fail."
  }
}

run "a_request_pending_then_provisioned_then_revoked_is_withdrawn" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "PendingProvisioning" }]
      }
    }
  }

  assert {
    condition     = output.request_status == "PendingProvisioning" && output.state == "request_accepted_only"
    error_message = "The first read is still pending."
  }
}

run "the_same_request_provisioned_on_a_later_apply_is_remembered" {
  command = apply

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "Provisioned" }]
      }
    }
  }

  assert {
    condition     = output.request_status == "Provisioned"
    error_message = "The later read-back status is the request status."
  }
}

run "and_a_revocation_after_that_is_withdrawn_not_rejected" {
  command = apply

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "Revoked" }]
      }
    }
  }

  assert {
    condition     = output.state == "withdrawn"
    error_message = "A success first seen after a pending read is remembered, so a later Revoked is a withdrawn grant and never fails the gate."
  }
}

run "a_request_revoked_after_it_was_granted_is_reported_not_failed" {
  command = apply

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "Revoked" }]
      }
    }
  }

  assert {
    condition     = output.request_status == "Revoked" && output.state == "withdrawn"
    error_message = "A request once seen granted and now revoked is a withdrawn grant, not a failed plan."
  }
}

run "a_request_that_is_no_longer_listed_is_reported_not_failed" {
  command = apply

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = []
      }
    }
  }

  assert {
    condition     = output.state == "request_unreadable"
    error_message = "A request that could be read before and is gone is reported in the state, and plan and destroy keep working."
  }
}

run "a_request_revoked_after_it_was_unreadable_is_still_withdrawn" {
  command = apply

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "Revoked" }]
      }
    }
  }

  assert {
    condition     = output.state == "withdrawn"
    error_message = "Pending, then Provisioned, then not listed, then Revoked must still be a withdrawn grant: nothing observed later resets the record of the submission."
  }
}

run "a_request_pending_at_creation_and_denied_later_is_reported_not_failed" {
  command = apply

  # Earlier runs of this file recorded another grant; replace it deliberately.
  plan_options {
    replace = [terraform_data.grant]
  }

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "PendingApproval" }]
      }
    }
  }
}

run "denied_on_a_later_apply_is_reported" {
  command = apply

  override_data {
    target = data.msgraph_resource.request
    values = {
      output = {
        requests = [{ id = "req-3", status = "Denied" }]
      }
    }
  }

  assert {
    condition     = output.state == "withdrawn"
    error_message = "A rejection after submission is reported in the state and is not an error."
  }
}
