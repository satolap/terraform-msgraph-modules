# v4.0.0 spelled the logic_app attributes in snake_case. Terraform drops an unknown object
# attribute silently, so the optional url is guarded against its old name trigger_url. The
# required attributes fail Terraform's own type conversion when only the old names are given.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "22222222-2222-2222-2222-222222222222"
      output = {
        unmanaged_properties = {
          callback_configuration = false
          client_configuration   = false
          behavior_on_error      = false
          other_authentication   = false
        }
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        extensions = []
      }
    }
  }
}

variables {
  accessPackageCatalog-id = "11111111-1111-1111-1111-111111111111"
  extension_type          = "request_workflow"
}

run "the_graph_names_are_accepted" {
  command = apply
  variables {
    logic_app = {
      subscriptionId       = "33333333-3333-3333-3333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
      url                  = "https://example.invalid/workflows/logic-example/triggers/manual/paths/invoke"
    }
  }
}

run "rejects_the_legacy_trigger_url" {
  command = plan
  variables {
    logic_app = {
      subscriptionId       = "33333333-3333-3333-3333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
      trigger_url          = "https://example.invalid/workflows/logic-example/triggers/manual/paths/invoke"
    }
  }
  expect_failures = [var.logic_app]
}

run "an_explicit_null_legacy_value_is_accepted" {
  command = apply
  variables {
    logic_app = {
      subscriptionId       = "33333333-3333-3333-3333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
      trigger_url          = null
    }
  }
}
