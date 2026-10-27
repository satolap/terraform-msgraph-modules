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
    {
      task         = "send_welcome_email"
      display_name = "Send welcome email"
      arguments    = { locale = "en-us", to = "User" }
    },
  ]
}

# The runs share one state in file order: the first creates the workflow, later
# runs update or replace it. A replacement takes the id of the override_resource
# block; an in-place update keeps the id in the state.

run "creates_a_disabled_workflow_without_scheduling" {
  command = apply

  assert {
    condition     = msgraph_resource.workflow.url == "identityGovernance/lifecycleWorkflows/workflows" && msgraph_resource.workflow.api_version == "v1.0"
    error_message = "The workflow must be created against the v1.0 workflows collection."
  }

  assert {
    condition     = msgraph_resource.workflow.body.isEnabled == false && msgraph_resource.workflow.body.isSchedulingEnabled == false
    error_message = "A workflow must be created disabled and with scheduling disabled."
  }

  assert {
    condition     = msgraph_resource.workflow.body.category == "joiner" && msgraph_resource.workflow.body.description == ""
    error_message = "The category and an empty description must be sent."
  }

  assert {
    condition = jsonencode(msgraph_resource.workflow.body.executionConditions) == jsonencode({
      "@odata.type" = "#microsoft.graph.identityGovernance.triggerAndScopeBasedConditions"
      scope = {
        "@odata.type" = "#microsoft.graph.identityGovernance.ruleBasedSubjectSet"
        rule          = "(department eq 'Marketing')"
      }
      trigger = {
        "@odata.type"      = "#microsoft.graph.identityGovernance.timeBasedAttributeTrigger"
        timeBasedAttribute = "employeeHireDate"
        offsetInDays       = -1
      }
    })
    error_message = "executionConditions must carry the rule-based scope and the time-based trigger in Graph's shape."
  }

  assert {
    condition     = length(msgraph_resource.workflow.body.tasks) == 2 && msgraph_resource.workflow.body.tasks[0].displayName == "Enable user account" && msgraph_resource.workflow.body.tasks[1].displayName == "Send welcome email"
    error_message = "Tasks must be sent in list order."
  }

  assert {
    condition     = msgraph_resource.workflow.body.tasks[0].taskDefinitionId == jsondecode(file("task-definitions.json"))["enable_user_account"].id && msgraph_resource.workflow.body.tasks[1].taskDefinitionId == jsondecode(file("task-definitions.json"))["send_welcome_email"].id
    error_message = "Task keys must resolve to the documented task definition IDs."
  }

  assert {
    condition     = jsonencode(msgraph_resource.workflow.body.tasks[1].arguments) == jsonencode([{ name = "locale", value = "en-us" }, { name = "to", value = "User" }])
    error_message = "Arguments must be sent as name/value pairs sorted by name."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.workflow.body.tasks[0]), "executionSequence") && !contains(keys(msgraph_resource.workflow.body), "administrationScopeTargets")
    error_message = "executionSequence and administrationScopeTargets must not be sent."
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.version == 1 && length(output.dangerous_task_keys) == 0
    error_message = "The outputs must expose the id, the version and no dangerous task."
  }
}

run "plans_an_on_demand_workflow_without_scope_or_trigger" {
  command = plan

  variables {
    execution_conditions = { type = "on_demand" }
  }

  assert {
    condition     = jsonencode(msgraph_resource.workflow.body.executionConditions) == jsonencode({ "@odata.type" = "#microsoft.graph.identityGovernance.onDemandExecutionOnly" })
    error_message = "An on-demand workflow must send only the onDemandExecutionOnly type."
  }
}

run "renaming_and_describing_update_in_place" {
  command = apply

  variables {
    display_name = "Onboard new hire (renamed)"
    description  = "Renamed workflow"
  }

  override_resource {
    target = msgraph_resource.workflow
    values = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-000000000002"
      output = {
        version               = 1
        is_enabled            = false
        is_scheduling_enabled = false
      }
    }
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "displayName and description are updatable, so they must update the workflow in place and keep its id."
  }

  assert {
    condition     = msgraph_resource.workflow.body.displayName == "Onboard new hire (renamed)" && msgraph_resource.workflow.body.description == "Renamed workflow"
    error_message = "The update must carry the new name and description."
  }
}

run "enabling_with_opt_in_updates_in_place" {
  command = apply

  variables {
    display_name          = "Onboard new hire (renamed)"
    description           = "Renamed workflow"
    is_enabled            = true
    is_scheduling_enabled = true
    activation_opt_in     = true
  }

  override_resource {
    target = msgraph_resource.workflow
    values = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-000000000003"
      output = {
        version               = 1
        is_enabled            = true
        is_scheduling_enabled = true
      }
    }
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && msgraph_resource.workflow.body.isEnabled == true && msgraph_resource.workflow.body.isSchedulingEnabled == true
    error_message = "isEnabled and isSchedulingEnabled are updatable, so enabling must update the workflow in place."
  }
}

run "changing_a_task_replaces_the_workflow" {
  command = apply

  variables {
    display_name          = "Onboard new hire (renamed)"
    description           = "Renamed workflow"
    is_enabled            = true
    is_scheduling_enabled = true
    activation_opt_in     = true
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
      id = "aaaaaaaa-aaaa-4aaa-8aaa-000000000004"
      output = {
        version               = 1
        is_enabled            = true
        is_scheduling_enabled = true
      }
    }
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-000000000004"
    error_message = "Tasks can only change with a new version, which the module does not create, so a task change must replace the workflow."
  }

  assert {
    condition     = length(terraform_data.immutable.input.tasks) == 1
    error_message = "The replace trigger must follow the tasks."
  }
}

run "changing_the_execution_conditions_replaces_the_workflow" {
  command = apply

  variables {
    display_name          = "Onboard new hire (renamed)"
    description           = "Renamed workflow"
    is_enabled            = true
    is_scheduling_enabled = true
    activation_opt_in     = true
    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Sales')"
      trigger = {
        time_based_attribute = "employeeHireDate"
        offset_in_days       = 0
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
      id = "aaaaaaaa-aaaa-4aaa-8aaa-000000000005"
      output = {
        version               = 1
        is_enabled            = true
        is_scheduling_enabled = true
      }
    }
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-000000000005" && terraform_data.immutable.input.executionConditions.scope.rule == "(department eq 'Sales')"
    error_message = "executionConditions can only change with a new version, so a change must replace the workflow."
  }
}

run "renaming_only_a_task_replaces_the_workflow" {
  command = apply

  variables {
    display_name          = "Onboard new hire (renamed)"
    description           = "Renamed workflow"
    is_enabled            = true
    is_scheduling_enabled = true
    activation_opt_in     = true
    execution_conditions = {
      type       = "trigger_and_scope"
      scope_rule = "(department eq 'Sales')"
      trigger = {
        time_based_attribute = "employeeHireDate"
        offset_in_days       = 0
      }
    }
    tasks = [
      {
        task         = "enable_user_account"
        display_name = "Enable the account"
      },
    ]
  }

  override_resource {
    target = msgraph_resource.workflow
    values = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-000000000006"
      output = {
        version               = 1
        is_enabled            = true
        is_scheduling_enabled = true
      }
    }
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-000000000006" && terraform_data.immutable.input.tasks[0].displayName == "Enable the account"
    error_message = "A task's name is sent only inside the workflow body, and the module sends no task PATCH, so renaming a task alone must replace the workflow."
  }
}
