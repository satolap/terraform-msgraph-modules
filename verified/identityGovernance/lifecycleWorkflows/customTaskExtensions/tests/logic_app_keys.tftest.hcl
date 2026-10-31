# The integration helper that reads the lifecycle extension fixture secret accepts the keys the
# secret has always had and the Graph-named keys of the module, and returns the module's object.

run "the_secret_keys_become_the_graph_named_object" {
  command = plan
  module {
    source = "./tests/integration/logic_app_keys"
  }
  variables {
    logic_app = {
      subscription_id         = "33333333-3333-4333-8333-333333333333"
      resource_group_name     = "rg-example"
      logic_app_workflow_name = "logic-example"
    }
  }
  assert {
    condition = jsonencode(output.logic_app) == jsonencode({
      subscriptionId       = "33333333-3333-4333-8333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
    })
    error_message = "The secret's keys must map to subscriptionId, resourceGroupName and logicAppWorkflowName."
  }
}

run "graph_named_keys_pass_through" {
  command = plan
  module {
    source = "./tests/integration/logic_app_keys"
  }
  variables {
    logic_app = {
      subscriptionId       = "33333333-3333-4333-8333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
    }
  }
  assert {
    condition = jsonencode(output.logic_app) == jsonencode({
      subscriptionId       = "33333333-3333-4333-8333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
    })
    error_message = "Graph-named keys must pass through."
  }
}
