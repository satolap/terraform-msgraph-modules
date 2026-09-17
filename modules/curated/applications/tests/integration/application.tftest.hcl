# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) with Application.ReadWrite.All.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_application_with_app_role" {
  command = apply

  variables {
    display_name = "tftest-app-${run.setup.suffix}"
    description  = "Created by terraform test; safe to delete"

    app_roles = [
      {
        id           = "3e64b81f-8a54-4b3b-9c76-1f4c50f4e123"
        display_name = "Contributor"
        description  = "Integration test app role"
        value        = "Contributor"
      },
    ]
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.app_id))
    error_message = "Graph must return a GUID appId for the created application."
  }

  assert {
    condition     = output.app_role_ids["Contributor"] == "3e64b81f-8a54-4b3b-9c76-1f4c50f4e123"
    error_message = "The app role must be registered with the supplied GUID."
  }
}

# Exercises the update (PATCH) path against the real API.
run "rename_application" {
  command = apply

  variables {
    display_name = "tftest-app-${run.setup.suffix}-renamed"
    description  = "Created by terraform test; safe to delete"

    app_roles = [
      {
        id           = "3e64b81f-8a54-4b3b-9c76-1f4c50f4e123"
        display_name = "Contributor"
        description  = "Integration test app role"
        value        = "Contributor"
      },
    ]
  }

  assert {
    condition     = output.display_name == "tftest-app-${run.setup.suffix}-renamed"
    error_message = "Renaming the application in place (PATCH) must be reflected in the response."
  }
}
