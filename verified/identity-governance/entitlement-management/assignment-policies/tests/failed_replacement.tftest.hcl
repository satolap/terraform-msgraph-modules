# An apply that changes access_package_id updates terraform_data.immutable
# before it replaces the policy. These runs simulate an apply that failed after
# that update and before the replacement policy existed: a run targeted at the
# trigger applies only the trigger. The state then holds the trigger at the new
# package and the old policy, so the next plan sees no trigger change. That plan
# must not look complete or move the old policy in place, and an apply with
# -replace must create the policy for the new package. The runs share one state
# in file order. A replacement takes the id of the override_resource block; an
# in-place update keeps the id in the state.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        custom_extension_stage_settings = []
      }
    }
  }
}

variables {
  access_package_id = "7777aaaa-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"
}

run "creates_the_policy" {
  command = apply

  override_resource {
    target = msgraph_resource.assignment_policy
    values = {
      id = "11111111-1111-1111-1111-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  assert {
    condition     = output.id == "11111111-1111-1111-1111-888888888888"
    error_message = "The first run must create the policy."
  }
}

# The apply that failed: only the trigger reached the new package.
run "a_failed_replacement_leaves_the_trigger_ahead" {
  command = apply

  variables {
    access_package_id = "99999999-9999-9999-9999-999999999999"
  }

  plan_options {
    target = [terraform_data.immutable]
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ access_package_id = "99999999-9999-9999-9999-999999999999" })
    error_message = "The simulated failure must leave the trigger at the new package."
  }
}

# The trigger has no change left, so the plan keeps the old policy. Its planned
# body still names the old package, which the postcondition reports.
run "the_next_plan_reports_the_unfinished_replacement" {
  command = plan

  variables {
    access_package_id = "99999999-9999-9999-9999-999999999999"
  }

  expect_failures = [msgraph_resource.assignment_policy]
}

run "replacing_the_policy_finishes_the_change" {
  command = apply

  variables {
    access_package_id = "99999999-9999-9999-9999-999999999999"
  }

  plan_options {
    replace = [msgraph_resource.assignment_policy]
  }

  override_resource {
    target = msgraph_resource.assignment_policy
    values = {
      id = "22222222-2222-2222-2222-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-888888888888"
    error_message = "An apply with -replace must create the policy again."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.accessPackage.id == "99999999-9999-9999-9999-999999999999"
    error_message = "The replacement must be created for the new access package."
  }
}

# After the replacement, a plan with the same inputs is complete again.
run "the_plan_after_the_replacement_passes" {
  command = plan

  variables {
    access_package_id = "99999999-9999-9999-9999-999999999999"
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.accessPackage.id == "99999999-9999-9999-9999-999999999999"
    error_message = "The replacement policy must keep the new access package."
  }
}
