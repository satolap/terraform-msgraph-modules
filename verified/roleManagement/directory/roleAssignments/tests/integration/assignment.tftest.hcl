# Credentialed live suite only. Terraform test tears down fixture state even on assertion failure.
# run_integration.py retains failed private state and an execution report for cleanup reconciliation.
# Keep the custom role in separate state: its ID must be known before assignment planning.
# Terraform test destroys this setup last, after both assignments and their principal.
run "setup" {
  command = apply
  module {
    source = "./tests/integration/setup"
  }
  assert {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", output.role_definition_id))
    error_message = "Setup must return the disposable custom role definition ID."
  }
}
run "create" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    second_role_definition_id = run.setup.role_definition_id
  }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      output.item.principalId == output.expected.principalId,
      output.item.roleDefinitionId == output.expected.roleDefinitionId,
      output.item.directoryScopeId == "/",
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
run "unchanged" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    second_role_definition_id = run.setup.role_definition_id
  }
  assert {
    condition = alltrue([
      output.id == run.create.id,
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
run "duplicate_pagination" {
  command = apply
  module {
    source = "../../../../../scripts/live_assignment_probes"
  }
  variables {
    probe         = "duplicate_pagination"
    tenant_id     = run.create.tenant_id
    assignment_id = run.create.id
    body          = run.create.expected
  }
  assert {
    condition     = output.passed
    error_message = "Read-only live guard probe must pass."
  }
}
run "mismatched_tenant" {
  command = apply
  module {
    source = "../../../../../scripts/live_assignment_probes"
  }
  variables {
    probe         = "mismatched_tenant"
    tenant_id     = run.create.tenant_id
    assignment_id = run.create.id
    body          = run.create.expected
  }
  assert {
    condition     = output.passed
    error_message = "Read-only live guard probe must pass."
  }
}
run "mismatched_identity" {
  command = apply
  module {
    source = "../../../../../scripts/live_assignment_probes"
  }
  variables {
    probe         = "mismatched_identity"
    tenant_id     = run.create.tenant_id
    assignment_id = run.create.id
    body          = run.create.expected
  }
  assert {
    condition     = output.passed
    error_message = "Read-only live guard probe must pass."
  }
}
# Selecting the SAME role by ID replaces the preflight without changing the
# tuple. The duplicate guard permits the new POST only after old-ID removal,
# even when Graph reuses the deterministic assignment ID.
run "destroy_first_replacement" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    second_role_definition_id = run.setup.role_definition_id
    use_role_id               = true
  }
  assert {
    condition     = output.item.principalId == run.create.expected.principalId && output.item.roleDefinitionId == run.create.expected.roleDefinitionId
    error_message = "Same-tuple replacement must pass the duplicate guard and independent GET."
  }
}
run "destroy_assignment" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    second_role_definition_id = run.setup.role_definition_id
    enabled                   = false
    removed_id                = run.destroy_first_replacement.id
  }
  assert {
    condition = alltrue([
      output.absent,
    ])
    error_message = "Independent GET must confirm the expected identity and lifecycle result."
  }
}
run "exact_id_absence" {
  command = apply
  module {
    source = "../../../../../scripts/live_assignment_probes"
  }
  variables {
    probe         = "exact_id_absence"
    tenant_id     = run.create.tenant_id
    assignment_id = run.destroy_first_replacement.id
    body          = run.create.expected
  }
  assert {
    condition     = output.passed
    error_message = "Only GET 404 of the saved exact ID may prove absence."
  }
}
