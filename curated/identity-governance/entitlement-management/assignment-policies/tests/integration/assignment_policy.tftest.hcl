# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with
# EntitlementManagement.ReadWrite.All, User.ReadWrite.All and Group.ReadWrite.All.
# Set TF_VAR_verified_domain and TF_VAR_initial_user_password for two disposable
# users. Their license assignment/readiness must be commissioned separately.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_policy" {
  command = apply

  variables {
    access_package_id    = run.setup.access_package_id
    display_name         = "tftest-policy-${run.setup.suffix}"
    description          = "Created by terraform test; safe to delete"
    allowed_target_scope = "specificDirectoryUsers"
    specific_allowed_targets = [
      { type = "groupMembers", id = run.setup.test_population_id },
    ]

    request_approval_settings = {
      is_approval_required_for_add = true
      stages = [{
        approval_timeout_in_days = 1
        primary_approvers        = [{ type = "singleUser", id = run.setup.approver_id }]
      }]
    }

    expiration = {
      type          = "afterDuration"
      duration_days = 90
    }

    requestor_settings = {
      enable_targets_to_self_add_access = true
    }
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID id for the created assignment policy."
  }

  assert {
    condition     = output.display_name == "tftest-policy-${run.setup.suffix}"
    error_message = "The created policy must carry the requested display name."
  }
}

# Exercises the update path against the real API — assignmentPolicies only
# supports PUT, which is exactly the update_method fix this module carries.
run "update_policy_via_put" {
  command = apply

  variables {
    access_package_id    = run.setup.access_package_id
    display_name         = "tftest-policy-${run.setup.suffix}-renamed"
    description          = "Updated by terraform test; safe to delete"
    allowed_target_scope = "specificDirectoryUsers"
    specific_allowed_targets = [
      { type = "groupMembers", id = run.setup.test_population_id },
    ]

    request_approval_settings = {
      is_approval_required_for_add = true
      stages = [{
        approval_timeout_in_days = 1
        primary_approvers        = [{ type = "singleUser", id = run.setup.approver_id }]
      }]
    }

    expiration = {
      type          = "afterDuration"
      duration_days = 30
    }

    requestor_settings = {
      enable_targets_to_self_add_access = true
    }
  }

  assert {
    condition     = output.display_name == "tftest-policy-${run.setup.suffix}-renamed"
    error_message = "Updating the policy in place (PUT) must be reflected in the response."
  }
}
