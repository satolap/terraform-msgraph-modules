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

# The "Run a custom task extension" task (issue 260). It is opt-in: the task needs
# acknowledged_custom_task_extension_ids naming the extension and a customTaskExtensionID argument that is a GUID.
# Nothing here calls Graph or any Logic App; a plan or an apply with the mock provider only builds
# the request body. expect_failures does not read messages; tests/test_lifecycle_workflows_module.py
# asserts them.

variables {
  display_name = "Onboard with extension"
  category     = "joiner"

  execution_conditions = {
    type = "on_demand"
  }

  tasks = [
    {
      task         = "enable_user_account"
      display_name = "Enable user account"
    },
    {
      task         = "run_a_custom_task_extension"
      display_name = "Notify the integration"
      arguments    = { customTaskExtensionID = "CCCCCCCC-cccc-4ccc-8ccc-cccccccccccc" }
    },
  ]
}

run "rejects_the_task_without_acknowledgement" {
  command = plan

  expect_failures = [msgraph_resource.workflow]
}

run "sends_the_extension_id_as_an_argument_once_acknowledged" {
  command = apply

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
  }

  assert {
    condition     = msgraph_resource.workflow.body.tasks[1].taskDefinitionId == jsondecode(file("task-definitions.json"))["run_a_custom_task_extension"].id
    error_message = "The task must resolve to the documented Run a Custom Task Extension definition."
  }

  assert {
    condition     = jsonencode(msgraph_resource.workflow.body.tasks[1].arguments) == jsonencode([{ name = "customTaskExtensionID", value = "CCCCCCCC-cccc-4ccc-8ccc-cccccccccccc" }])
    error_message = "The extension ID must be sent unchanged as the customTaskExtensionID argument."
  }

  assert {
    condition     = jsonencode(output.custom_task_extension_ids) == jsonencode(["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]) && length(output.dangerous_task_keys) == 0
    error_message = "The output must list the lower-case extension ID, and the task must not count as dangerous."
  }

  assert {
    condition     = msgraph_resource.workflow.body.isEnabled == false && msgraph_resource.workflow.body.isSchedulingEnabled == false
    error_message = "A workflow with a custom task extension must still be created disabled."
  }
}

run "the_acknowledgement_does_not_cover_dangerous_tasks" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    category                               = "leaver"
    tasks = [
      { task = "disable_user_account", display_name = "Disable" },
      { task = "run_a_custom_task_extension", display_name = "Notify", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" } },
    ]
  }

  expect_failures = [msgraph_resource.workflow]
}

run "the_dangerous_acknowledgement_does_not_cover_the_extension_task" {
  command = plan

  variables {
    acknowledge_dangerous_tasks = true
    category                    = "leaver"
    tasks = [
      { task = "disable_user_account", display_name = "Disable" },
      { task = "run_a_custom_task_extension", display_name = "Notify", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" } },
    ]
  }

  expect_failures = [msgraph_resource.workflow]
}

run "both_acknowledgements_allow_both_kinds_of_task" {
  command = plan

  variables {
    acknowledge_dangerous_tasks            = true
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    category                               = "leaver"
    tasks = [
      { task = "disable_user_account", display_name = "Disable" },
      { task = "run_a_custom_task_extension", display_name = "Notify", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" } },
    ]
  }

  assert {
    condition     = length(msgraph_resource.workflow.body.tasks) == 2
    error_message = "Both tasks must be sent once both acknowledgements are given."
  }
}

run "rejects_a_missing_extension_id" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks = [
      { task = "run_a_custom_task_extension", display_name = "Notify" },
    ]
  }

  expect_failures = [var.tasks]
}

run "rejects_an_extension_id_that_is_not_a_guid" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks = [
      { task = "run_a_custom_task_extension", display_name = "Notify", arguments = { customTaskExtensionID = "my-logic-app" } },
    ]
  }

  expect_failures = [var.tasks]
}

run "rejects_an_extension_id_with_trailing_text" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks = [
      { task = "run_a_custom_task_extension", display_name = "Notify", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc\n" } },
    ]
  }

  expect_failures = [var.tasks]
}

run "rejects_an_undocumented_argument_next_to_the_extension_id" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks = [
      { task = "run_a_custom_task_extension", display_name = "Notify", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc", url = "https://example.invalid" } },
    ]
  }

  expect_failures = [var.tasks]
}

run "an_ordinary_workflow_needs_no_custom_task_acknowledgement" {
  command = plan

  variables {
    tasks = [{ task = "enable_user_account", display_name = "Enable" }]
  }

  assert {
    condition     = length(output.custom_task_extension_ids) == 0
    error_message = "A workflow without the extension task must list no extension ID."
  }
}

run "changing_the_extension_replaces_the_workflow_through_the_immutable_trigger" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input.tasks[1].arguments) == jsonencode([{ name = "customTaskExtensionID", value = "CCCCCCCC-cccc-4ccc-8ccc-cccccccccccc" }])
    error_message = "The replacement trigger must hold the extension argument, because only a new workflow version can change it."
  }
}

run "changing_the_extension_id_without_updating_the_acknowledgement_fails" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks = [
      { task = "run_a_custom_task_extension", display_name = "Notify", arguments = { customTaskExtensionID = "dddddddd-dddd-4ddd-8ddd-dddddddddddd" } },
    ]
  }

  expect_failures = [msgraph_resource.workflow]
}

run "adding_a_second_extension_needs_its_own_acknowledgement" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks = [
      { task = "run_a_custom_task_extension", display_name = "First", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" } },
      { task = "run_a_custom_task_extension", display_name = "Second", arguments = { customTaskExtensionID = "dddddddd-dddd-4ddd-8ddd-dddddddddddd" } },
    ]
  }

  expect_failures = [msgraph_resource.workflow]
}

run "acknowledging_both_extensions_passes" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["dddddddd-dddd-4ddd-8ddd-dddddddddddd", "cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks = [
      { task = "run_a_custom_task_extension", display_name = "First", arguments = { customTaskExtensionID = "cccccccc-cccc-4ccc-8ccc-cccccccccccc" } },
      { task = "run_a_custom_task_extension", display_name = "Second", arguments = { customTaskExtensionID = "DDDDDDDD-dddd-4ddd-8ddd-dddddddddddd" } },
    ]
  }

  assert {
    condition     = length(output.custom_task_extension_ids) == 2
    error_message = "Both extension IDs must be listed, compared in lower case."
  }
}

run "an_acknowledgement_that_is_no_longer_used_fails" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["cccccccc-cccc-4ccc-8ccc-cccccccccccc"]
    tasks                                  = [{ task = "enable_user_account", display_name = "Enable" }]
  }

  expect_failures = [msgraph_resource.workflow]
}

run "rejects_an_acknowledged_id_that_is_not_a_guid" {
  command = plan

  variables {
    acknowledged_custom_task_extension_ids = ["my-extension"]
  }

  expect_failures = [var.acknowledged_custom_task_extension_ids]
}
