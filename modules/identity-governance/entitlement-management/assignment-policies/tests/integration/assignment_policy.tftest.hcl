# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with
# EntitlementManagement.ReadWrite.All.

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
    allowed_target_scope = "allMemberUsers"

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
    allowed_target_scope = "allMemberUsers"

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
