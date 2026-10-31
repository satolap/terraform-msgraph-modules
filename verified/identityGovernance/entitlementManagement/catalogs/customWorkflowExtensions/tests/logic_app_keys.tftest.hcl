# The integration helper that reads the Logic App fixture secret accepts the keys the secret
# has always had and the Graph-named keys of the module, and returns the module's object.

run "the_secret_keys_become_the_graph_named_object" {
  command = plan
  module {
    source = "./tests/integration/logic_app_keys"
  }
  variables {
    logic_app = {
      subscription_id     = "33333333-3333-4333-8333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "https://example.invalid/workflows/logic-example/triggers/manual/paths/invoke"
    }
  }
  assert {
    condition = jsonencode(output.logic_app) == jsonencode({
      subscriptionId       = "33333333-3333-4333-8333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
      url                  = "https://example.invalid/workflows/logic-example/triggers/manual/paths/invoke"
    })
    error_message = "The secret's keys must map to subscriptionId, resourceGroupName, logicAppWorkflowName and url."
  }
}

run "graph_named_keys_pass_through_and_the_url_is_optional" {
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
      url                  = null
    })
    error_message = "Graph-named keys must pass through and an absent url must be null."
  }
}

run "a_graph_named_key_wins_over_the_secret_key" {
  command = plan
  module {
    source = "./tests/integration/logic_app_keys"
  }
  variables {
    logic_app = {
      subscriptionId      = "33333333-3333-4333-8333-333333333333"
      subscription_id     = "44444444-4444-4444-8444-444444444444"
      resourceGroupName   = "rg-new"
      resource_group_name = "rg-old"
      workflow_name       = "logic-example"
    }
  }
  assert {
    condition     = output.logic_app.subscriptionId == "33333333-3333-4333-8333-333333333333" && output.logic_app.resourceGroupName == "rg-new" && output.logic_app.logicAppWorkflowName == "logic-example"
    error_message = "A Graph-named key must win over the secret's key, and keys may be mixed."
  }
}
