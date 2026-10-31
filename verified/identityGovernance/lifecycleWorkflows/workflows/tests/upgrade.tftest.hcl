# A workflow that v4.0.0 created keeps its saved state after the inputs took Graph's names: the
# upgrade must neither replace the workflow nor update it in place. A mocked provider does not
# show an update in the computed output, so the exported keys, which would make the provider
# update every saved workflow, are compared with the ones the v4.0.0 module saved.
# tests/previous is the v4.0.0 module without its name_pattern input and precondition, which
# the module scans would otherwise count as a module.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
      output = {
        version               = 1
        is_enabled            = false
        is_scheduling_enabled = false
      }
    }
  }
}

run "v4_0_0_creates_the_workflow" {
  state_key = "upgrade"
  command   = apply
  module { source = "./tests/previous" }

  variables {
    display_name = "Onboard new hire"
    category     = "joiner"

    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Marketing')"
      trigger = {
        time_based_attribute = "employeeHireDate"
        offset_in_days       = -1
      }
    }

    tasks = [
      {
        task         = "enable_user_account"
        display_name = "Enable user account"
      },
    ]
  }

  override_resource {
    target = msgraph_resource.workflow
    values = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      output = {
        version               = 7
        is_enabled            = false
        is_scheduling_enabled = false
      }
    }
  }
}

run "the_upgrade_keeps_the_saved_workflow_unchanged" {
  state_key = "upgrade"
  command   = apply

  variables {
    displayName = "Onboard new hire"
    category    = "joiner"

    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Marketing')"
      trigger = {
        timeBasedAttribute = "employeeHireDate"
        offsetInDays       = -1
      }
    }

    tasks = [
      {
        task        = "enable_user_account"
        displayName = "Enable user account"
      },
    ]
  }

  assert {
    condition     = msgraph_resource.workflow.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "The upgrade must not replace the workflow."
  }

  # The exported keys are part of the saved resource: another key set is an in-place update.
  assert {
    condition     = jsonencode(msgraph_resource.workflow.response_export_values) == jsonencode(run.v4_0_0_creates_the_workflow.export_values)
    error_message = "The upgrade must not change the exported values, which would update every workflow in place."
  }

  assert {
    condition     = msgraph_resource.workflow.output.version == 7
    error_message = "The upgrade must not update the workflow in place."
  }
}
