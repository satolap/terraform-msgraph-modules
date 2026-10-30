# Credentialed live suite only. Terraform test tears down fixture state even on assertion failure.
# run_integration.py retains failed private state and an execution report for cleanup reconciliation.
run "create" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.isBuiltIn == false,
      output.item.isEnabled == true,
      startswith(output.item.displayName, "tftest-reader-"),
      toset(output.item.rolePermissions[0].allowedResourceActions) == toset(["microsoft.directory/applications/standard/read"]),
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
run "update" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    description = "Updated by terraform test; safe to delete"
  }
  assert {
    condition = alltrue([
      output.id == run.create.id,
      output.item.description == "Updated by terraform test; safe to delete",
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
run "destroy_definition" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    enabled    = false
    removed_id = run.create.id
  }
  assert {
    condition = alltrue([
      output.absent,
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
