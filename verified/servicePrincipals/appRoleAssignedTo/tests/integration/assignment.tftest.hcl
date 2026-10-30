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
      output.item.resourceId == output.expected.resourceId,
      output.item.principalId == output.expected.principalId,
      output.item.appRoleId == output.expected.appRoleId,
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
run "unchanged" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  assert {
    condition = alltrue([
      output.id == run.create.id,
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
run "destroy_assignment" {
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
