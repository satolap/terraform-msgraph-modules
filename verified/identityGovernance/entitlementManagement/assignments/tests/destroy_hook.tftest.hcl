# The destroy hook's inputs. Plans only: an apply would run the real hook at
# teardown. The hook's shell is exercised separately with stub az and curl
# (tests/test_access_package_assignments.py).
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
  target_id            = "11111111-1111-1111-1111-111111111111"
  access_package_id    = "22222222-2222-2222-2222-222222222222"
  assignment_policy_id = "33333333-3333-3333-3333-333333333333"
}

run "records_the_identity_that_the_hook_revokes" {
  command = plan

  assert {
    condition = (
      null_resource.remove_on_destroy[0].triggers["target_id"] == "11111111-1111-1111-1111-111111111111"
      && null_resource.remove_on_destroy[0].triggers["access_package_id"] == "22222222-2222-2222-2222-222222222222"
      && null_resource.remove_on_destroy[0].triggers["assignment_policy_id"] == "33333333-3333-3333-3333-333333333333"
    )
    error_message = "The hook must capture the subject, the package and the policy that it revokes."
  }

  assert {
    condition     = null_resource.remove_on_destroy[0].triggers["revoke"] == "true" && null_resource.remove_on_destroy[0].triggers["adopted_assignment_id"] == ""
    error_message = "An assignment this module granted must be revoked on destroy."
  }

  assert {
    condition     = null_resource.remove_on_destroy[0].triggers["api_version"] == "v1.0"
    error_message = "The hook must target v1.0."
  }
}

run "an_adopted_assignment_is_left_in_place_by_default" {
  command = plan

  variables {
    adopt_assignment_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
  }

  assert {
    condition     = null_resource.remove_on_destroy[0].triggers["revoke"] == "false" && null_resource.remove_on_destroy[0].triggers["adopted_assignment_id"] == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "Destroying must not revoke access that this module only adopted."
  }
}

run "an_adopted_assignment_is_revoked_only_on_request" {
  command = plan

  variables {
    adopt_assignment_id                  = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    revoke_adopted_assignment_on_destroy = true
  }

  assert {
    condition     = null_resource.remove_on_destroy[0].triggers["revoke"] == "true"
    error_message = "revoke_adopted_assignment_on_destroy must make the hook revoke the adopted assignment."
  }
}

run "a_new_replacement_token_reaches_the_hook" {
  command = plan

  variables {
    replacement_token = "renewal-2"
  }

  assert {
    condition     = null_resource.remove_on_destroy[0].triggers["replacement_token"] == "renewal-2" && terraform_data.identity.input.replacement_token == "renewal-2"
    error_message = "A replacement token must change the hook, so the old assignment is revoked before the new request."
  }
}

run "the_hook_can_be_disabled" {
  command = plan

  variables {
    enable_destroy_cleanup = false
  }

  assert {
    condition     = length(null_resource.remove_on_destroy) == 0
    error_message = "enable_destroy_cleanup = false must create no hook."
  }
}
