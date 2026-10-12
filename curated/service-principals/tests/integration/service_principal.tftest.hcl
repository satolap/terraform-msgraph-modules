# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with Application.ReadWrite.All.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_service_principal" {
  command = apply

  variables {
    app_id                       = run.setup.app_id
    app_role_assignment_required = true
    notes                        = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID object id for the created service principal."
  }

  assert {
    condition     = output.app_id == run.setup.app_id
    error_message = "The service principal must be linked to the setup application."
  }
}
