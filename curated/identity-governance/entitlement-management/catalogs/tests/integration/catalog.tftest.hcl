# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with
# EntitlementManagement.ReadWrite.All.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_unpublished_catalog" {
  command = apply

  variables {
    display_name = "tftest-catalog-${run.setup.suffix}"
    description  = "Created by terraform test; safe to delete"
    state        = "unpublished"
  }

  assert {
    condition     = output.state == "unpublished"
    error_message = "Graph must report the catalog as unpublished."
  }
}

# Exercises the update (PATCH) path against the real API.
run "publish_catalog" {
  command = apply

  variables {
    display_name = "tftest-catalog-${run.setup.suffix}"
    description  = "Created by terraform test; safe to delete"
    state        = "published"
  }

  assert {
    condition     = output.state == "published"
    error_message = "Publishing the catalog in place (PATCH) must be reflected in the response."
  }
}
