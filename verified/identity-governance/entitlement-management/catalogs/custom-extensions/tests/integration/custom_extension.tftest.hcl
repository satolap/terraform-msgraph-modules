# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials with
# EntitlementManagement.ReadWrite.All, a tenant licensed for Microsoft Entra ID
# Governance or Entra Suite, and an existing Consumption Logic App passed as
# TF_VAR_logic_app (subscription_id, resource_group_name, workflow_name and the
# trigger_url without a shared access signature). The live runner skips this suite
# when TF_VAR_logic_app is not set. Nothing here invokes the Logic App.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_request_workflow_extension" {
  command = apply

  variables {
    catalog_id     = run.setup.catalog_id
    extension_type = "request_workflow"
    display_name   = "tftest-extension-${run.setup.suffix}"
    description    = "Created by terraform test; safe to delete"
  }

  assert {
    condition     = output.odata_type == "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension"
    error_message = "Graph must report the request workflow extension type."
  }

  assert {
    condition     = output.catalog_id == lower(run.setup.catalog_id)
    error_message = "The extension must live in the setup catalog."
  }
}

# Exercises the documented update (PUT) path: a changed description keeps the id.
run "update_description_in_place" {
  command = apply

  variables {
    catalog_id     = run.setup.catalog_id
    extension_type = "request_workflow"
    display_name   = "tftest-extension-${run.setup.suffix}"
    description    = "Updated by terraform test; safe to delete"
  }

  assert {
    condition     = output.id == run.create_request_workflow_extension.id
    error_message = "A description change must update the extension in place, not replace it."
  }
}

# The type cannot be updated, so the module replaces the extension.
run "replace_with_assignment_workflow_extension" {
  command = apply

  # A distinct name, so the replacement does not collide with the extension it replaces
  # while both exist (create before destroy).
  variables {
    catalog_id     = run.setup.catalog_id
    extension_type = "assignment_workflow"
    display_name   = "tftest-extension-${run.setup.suffix}-assignment"
    description    = "Updated by terraform test; safe to delete"
  }

  assert {
    condition     = output.odata_type == "#microsoft.graph.accessPackageAssignmentWorkflowExtension"
    error_message = "Graph must report the assignment workflow extension type."
  }

  assert {
    condition     = output.id != run.create_request_workflow_extension.id
    error_message = "Changing extension_type must replace the extension."
  }
}
