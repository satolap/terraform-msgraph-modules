mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      output = {
        version               = 1
        is_enabled            = false
        is_scheduling_enabled = false
      }
    }
  }
}

variables {
  display_name = "Offboard leaver"
  category     = "leaver"

  execution_conditions = {
    type       = "trigger_and_scope"
    scope_rule = "(department eq 'Marketing')"
    trigger = {
      time_based_attribute = "employeeLeaveDateTime"
      offset_in_days       = 1
    }
  }

  tasks = [
    {
      task         = "send_email_on_users_last_day"
      display_name = "Send last day email"
    },
  ]
}

# expect_failures does not read messages; the README documents each rule and
# tests/test_lifecycle_workflows_module.py asserts the messages.

run "accepts_the_mover_category" {
  command = plan

  variables {
    category = "mover"
    tasks = [
      {
        task         = "add_user_to_groups"
        display_name = "Add to groups"
        arguments    = { groupID = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
      },
    ]
  }

  assert {
    condition     = msgraph_resource.workflow.body.category == "mover"
    error_message = "mover is used by the documented examples and must be accepted."
  }
}

run "rejects_unknown_future_value_category" {
  command = plan

  variables {
    category = "unknownFutureValue"
  }

  expect_failures = [var.category]
}

run "rejects_empty_display_name" {
  command = plan

  variables {
    display_name = " "
  }

  expect_failures = [var.display_name]
}

run "rejects_unknown_execution_condition_type" {
  command = plan

  variables {
    execution_conditions = { type = "event_based" }
  }

  expect_failures = [var.execution_conditions]
}

run "rejects_a_schedule_without_a_scope_rule" {
  command = plan

  variables {
    execution_conditions = {
      type = "trigger_and_scope"
      trigger = {
        time_based_attribute = "employeeLeaveDateTime"
      }
    }
  }

  expect_failures = [var.execution_conditions]
}

run "rejects_an_empty_scope_rule" {
  command = plan

  variables {
    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "  "
      trigger = {
        time_based_attribute = "employeeLeaveDateTime"
      }
    }
  }

  expect_failures = [var.execution_conditions]
}

run "rejects_a_trigger_on_an_on_demand_workflow" {
  command = plan

  variables {
    execution_conditions = {
      type = "on_demand"
      trigger = {
        time_based_attribute = "employeeLeaveDateTime"
      }
    }
  }

  expect_failures = [var.execution_conditions]
}

run "rejects_an_unknown_trigger_attribute" {
  command = plan

  variables {
    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Marketing')"
      trigger = {
        time_based_attribute = "managerChange"
      }
    }
  }

  expect_failures = [var.execution_conditions]
}

run "rejects_an_offset_beyond_180_days" {
  command = plan

  variables {
    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Marketing')"
      trigger = {
        time_based_attribute = "employeeLeaveDateTime"
        offset_in_days       = 181
      }
    }
  }

  expect_failures = [var.execution_conditions]
}

run "rejects_no_tasks" {
  command = plan

  variables {
    tasks = []
  }

  expect_failures = [var.tasks]
}

run "rejects_a_task_that_is_not_a_built_in_definition" {
  command = plan

  variables {
    tasks = [{ task = "format_hard_drive", display_name = "Nope" }]
  }

  expect_failures = [var.tasks]
}

run "rejects_the_custom_task_extension_task_without_acknowledgement" {
  command = plan

  variables {
    tasks = [{ task = "run_a_custom_task_extension", display_name = "Extension", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" } }]
  }

  expect_failures = [msgraph_resource.workflow]
}

run "rejects_a_task_outside_the_workflow_category" {
  command = plan

  variables {
    tasks = [{ task = "send_welcome_email", display_name = "Welcome" }]
  }

  expect_failures = [var.tasks]
}

run "rejects_an_undocumented_argument_name" {
  command = plan

  variables {
    tasks = [{ task = "send_email_on_users_last_day", display_name = "Last day", arguments = { recipient = "User" } }]
  }

  expect_failures = [var.tasks]
}

run "rejects_an_enum_argument_outside_its_values" {
  command = plan

  variables {
    tasks                       = [{ task = "disable_user_account", display_name = "Disable", arguments = { disableOnPremisesAccount = "maybe" } }]
    acknowledge_dangerous_tasks = true
  }

  expect_failures = [var.tasks]
}

run "accepts_a_free_form_string_argument" {
  command = plan

  variables {
    tasks = [{ task = "send_email_on_users_last_day", display_name = "Last day", arguments = { customSubject = "Goodbye", to = "Manager" } }]
  }

  assert {
    condition     = length(msgraph_resource.workflow.body.tasks[0].arguments) == 2
    error_message = "A string parameter is not limited to its listed example values."
  }
}

run "rejects_enabling_without_opt_in" {
  command = plan

  variables {
    is_enabled = true
  }

  expect_failures = [msgraph_resource.workflow]
}

run "rejects_enabling_scheduling_alone_without_opt_in" {
  command = plan

  variables {
    is_scheduling_enabled = true
  }

  expect_failures = [msgraph_resource.workflow]
}

run "accepts_enabling_scheduling_alone_with_opt_in" {
  command = plan

  variables {
    is_scheduling_enabled = true
    activation_opt_in     = true
  }

  assert {
    condition     = msgraph_resource.workflow.body.isEnabled == false && msgraph_resource.workflow.body.isSchedulingEnabled == true
    error_message = "The two flags are independent."
  }
}

run "rejects_a_dangerous_task_without_acknowledgement" {
  command = plan

  variables {
    tasks = [{ task = "disable_user_account", display_name = "Disable" }]
  }

  expect_failures = [msgraph_resource.workflow]
}

run "accepts_a_dangerous_task_with_acknowledgement" {
  command = plan

  variables {
    tasks                       = [{ task = "disable_user_account", display_name = "Disable", arguments = { disableOnPremisesAccount = "false" } }]
    acknowledge_dangerous_tasks = true
  }

  assert {
    condition     = jsonencode(output.dangerous_task_keys) == jsonencode(["disable_user_account"])
    error_message = "The dangerous task must be listed."
  }

  assert {
    condition     = msgraph_resource.workflow.body.isEnabled == false
    error_message = "Acknowledging a dangerous task must not enable the workflow."
  }
}
