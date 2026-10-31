# A caller upgrading from v4.0.0 who keeps a snake_case nested name must fail at plan time:
# the object type would otherwise drop the name and fall back to its default (a task that is
# disabled in the caller's configuration would run, an error-tolerant task would stop the run).
# Each rejection run is paired with an accepting run without the legacy name.
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
  displayName = "Offboard leaver"
  category    = "leaver"

  execution_conditions = {
    type       = "trigger_and_scope"
    scope_rule = "(department eq 'Marketing')"
    trigger = {
      timeBasedAttribute = "employeeLeaveDateTime"
      offsetInDays       = 1
    }
  }

  tasks = [
    {
      task        = "send_email_on_users_last_day"
      displayName = "Send last day email"
    },
  ]
}

run "graph_names_are_accepted" {
  command = plan
  variables {
    tasks = [
      {
        task            = "send_email_on_users_last_day"
        displayName     = "Send last day email"
        continueOnError = true
        isEnabled       = false
      },
    ]
  }
  assert {
    condition     = msgraph_resource.workflow.body.tasks[0].isEnabled == false && msgraph_resource.workflow.body.tasks[0].continueOnError == true
    error_message = "The Graph-named task flags must be sent."
  }
}

run "tasks_reject_is_enabled" {
  command = plan
  variables {
    tasks = [
      {
        task        = "send_email_on_users_last_day"
        displayName = "Send last day email"
        is_enabled  = false
      },
    ]
  }
  expect_failures = [var.tasks]
}

run "tasks_reject_continue_on_error" {
  command = plan
  variables {
    tasks = [
      {
        task              = "send_email_on_users_last_day"
        displayName       = "Send last day email"
        continue_on_error = true
      },
    ]
  }
  expect_failures = [var.tasks]
}

run "tasks_reject_a_legacy_name_on_a_later_task" {
  command = plan
  variables {
    tasks = [
      {
        task        = "send_email_on_users_last_day"
        displayName = "Send last day email"
      },
      {
        task        = "send_email_on_users_last_day"
        displayName = "Send it again"
        is_enabled  = false
      },
    ]
  }
  expect_failures = [var.tasks]
}

run "tasks_accept_explicit_null_legacy_names" {
  command = plan
  variables {
    tasks = [
      {
        task              = "send_email_on_users_last_day"
        displayName       = "Send last day email"
        is_enabled        = null
        continue_on_error = null
      },
    ]
  }
}

run "execution_conditions_reject_offset_in_days" {
  command = plan
  variables {
    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Marketing')"
      trigger = {
        timeBasedAttribute = "employeeLeaveDateTime"
        offset_in_days     = 1
      }
    }
  }
  expect_failures = [var.execution_conditions]
}

run "execution_conditions_accept_explicit_null_legacy_names" {
  command = plan
  variables {
    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Marketing')"
      trigger = {
        timeBasedAttribute = "employeeLeaveDateTime"
        offsetInDays       = 1
        offset_in_days     = null
      }
    }
  }
}
