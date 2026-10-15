# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with
# EntitlementManagement.ReadWrite.All.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_access_package" {
  command = apply

  variables {
    catalog_id   = run.setup.catalog_id
    display_name = "tftest-package-${run.setup.suffix}"
    description  = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID id for the created access package."
  }

  assert {
    condition     = output.display_name == "tftest-package-${run.setup.suffix}"
    error_message = "The created access package must carry the requested display name."
  }
}

# Exercises the update (PATCH) path against the real API.
run "update_access_package" {
  command = apply

  variables {
    catalog_id   = run.setup.catalog_id
    display_name = "tftest-package-${run.setup.suffix}-renamed"
    description  = "Created by terraform test; safe to delete"
    is_hidden    = true
  }

  assert {
    condition     = output.display_name == "tftest-package-${run.setup.suffix}-renamed"
    error_message = "Renaming the access package in place (PATCH) must be reflected in the response."
  }
}
