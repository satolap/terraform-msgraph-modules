# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with Group.ReadWrite.All.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_group" {
  command = apply

  variables {
    display_name  = "tftest-group-${run.setup.suffix}"
    mail_nickname = "tftest-group-${run.setup.suffix}"
    description   = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID object id for the created group."
  }

  assert {
    condition     = output.display_name == "tftest-group-${run.setup.suffix}"
    error_message = "The created group must carry the requested display name."
  }
}

# Exercises the update (PATCH) path against the real API.
run "rename_group" {
  command = apply

  variables {
    display_name  = "tftest-group-${run.setup.suffix}-renamed"
    mail_nickname = "tftest-group-${run.setup.suffix}"
    description   = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = output.display_name == "tftest-group-${run.setup.suffix}-renamed"
    error_message = "Renaming the group in place (PATCH) must be reflected in the response."
  }
}
