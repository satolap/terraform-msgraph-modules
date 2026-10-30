# Read-only acceptance: no PATCH, DELETE, snapshot restore or user lifecycle changes.
run "read" {
  command = apply
  module { source = "./tests/integration/fixture" }
  assert {
    condition     = can(output.settings.id) && can(output.settings.externalUserLifecycleAction)
    error_message = "Independent GET must return the singleton identity and lifecycle setting."
  }
}
run "unchanged" {
  command = apply
  module { source = "./tests/integration/fixture" }
  assert {
    condition     = output.settings == run.read.settings
    error_message = "Read-only probe must preserve the entire observed singleton."
  }
}
