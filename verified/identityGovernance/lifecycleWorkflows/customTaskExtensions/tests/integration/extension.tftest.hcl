# Credentialed live suite only. Fixture state is retained privately on failed cleanup.

run "create" {
  command = apply
  module { source = "./tests/integration/fixture" }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      startswith(output.item.displayName, "tftest-extension-"),
      output.item.endpointConfiguration.subscriptionId == output.expected.logic_app.subscription_id,
      output.item.endpointConfiguration.resourceGroupName == output.expected.logic_app.resource_group_name,
      output.item.endpointConfiguration.logicAppWorkflowName == output.expected.logic_app.logic_app_workflow_name,
      output.item.authenticationConfiguration.resourceId == output.expected.authentication_resource_id,
      output.item.clientConfiguration.timeoutInMilliseconds == 1000,
      output.item.clientConfiguration.maximumRetries == 0,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "update" {
  command = apply
  module { source = "./tests/integration/fixture" }
  variables {
    description = "Updated by terraform test; safe to delete"
  }
  assert {
    condition = alltrue([
      output.item.id == output.id,
      startswith(output.item.displayName, "tftest-extension-"),
      output.item.endpointConfiguration.subscriptionId == output.expected.logic_app.subscription_id,
      output.item.endpointConfiguration.resourceGroupName == output.expected.logic_app.resource_group_name,
      output.item.endpointConfiguration.logicAppWorkflowName == output.expected.logic_app.logic_app_workflow_name,
      output.item.authenticationConfiguration.resourceId == output.expected.authentication_resource_id,
      output.item.clientConfiguration.timeoutInMilliseconds == 1000,
      output.item.clientConfiguration.maximumRetries == 0,
      output.id == run.create.id,
      output.item.description == "Updated by terraform test; safe to delete",
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}

run "destroy_extension" {
  command = apply
  module { source = "./tests/integration/fixture" }
  variables {
    enabled    = false
    removed_id = run.create.id
  }
  assert {
    condition = alltrue([
      output.absent,
    ])
    error_message = "Independent Graph GET must confirm identity, safety and lifecycle results."
  }
}
