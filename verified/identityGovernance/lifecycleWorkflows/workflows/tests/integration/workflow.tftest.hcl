# Credentialed live suite only. Fixture state is retained privately on failed cleanup.

run "create" {
  command = apply
  module { source = "./tests/integration/fixture" }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.isEnabled == false,
      output.item.isSchedulingEnabled == false,
      output.item.tasks[0].isEnabled == false,
      startswith(output.item.displayName, "tftest-workflow-"),
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "update" {
  command = apply
  module { source = "./tests/integration/fixture" }
  variables {
    description = "Updated by terraform test; safe to delete"
  }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.isEnabled == false,
      output.item.isSchedulingEnabled == false,
      output.item.tasks[0].isEnabled == false,
      startswith(output.item.displayName, "tftest-workflow-"),
      output.id == run.create.id,
      output.item.description == "Updated by terraform test; safe to delete",
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "destroy_workflow" {
  command = apply
  module { source = "./tests/integration/fixture" }
  variables {
    enabled    = false
    removed_id = run.create.id
  }
  assert {
    condition = alltrue([
      output.absent,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}
