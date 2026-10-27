mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      output = {
        created_date_time       = "2026-01-01T00:00:00Z"
        last_modified_date_time = "2026-01-01T00:00:00Z"
      }
    }
  }
}

variables {
  display_name = "Grant manager access"

  logic_app = {
    subscription_id         = "11111111-1111-4111-8111-111111111111"
    resource_group_name     = "rg-example"
    logic_app_workflow_name = "example-logic-app"
  }

  authentication_resource_id = "22222222-2222-4222-8222-222222222222"
}

# Nothing here calls Graph or a Logic App: the mock provider only records the request body. The runs
# share one state in file order; every change is an in-place update, so the ID never changes.

run "creates_the_extension_with_the_documented_shape" {
  command = apply

  assert {
    condition     = msgraph_resource.extension.url == "identityGovernance/lifecycleWorkflows/customTaskExtensions" && msgraph_resource.extension.api_version == "v1.0"
    error_message = "The extension must be created against the v1.0 customTaskExtensions collection."
  }

  assert {
    condition = jsonencode(msgraph_resource.extension.body) == jsonencode({
      displayName = "Grant manager access"
      description = ""
      endpointConfiguration = {
        "@odata.type"        = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
        subscriptionId       = "11111111-1111-4111-8111-111111111111"
        resourceGroupName    = "rg-example"
        logicAppWorkflowName = "example-logic-app"
      }
      authenticationConfiguration = {
        "@odata.type" = "#microsoft.graph.azureAdTokenAuthentication"
        resourceId    = "22222222-2222-4222-8222-222222222222"
      }
      clientConfiguration = {
        "@odata.type"         = "#microsoft.graph.customExtensionClientConfiguration"
        timeoutInMilliseconds = 1000
      }
    })
    error_message = "The body must carry only the documented create properties; without a callback duration it has no callbackConfiguration and without maximum_retries no maximumRetries."
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.reply_mode == "none" && output.display_name == "Grant manager access"
    error_message = "The outputs must expose the id, the derived reply mode none and the display name."
  }

  assert {
    condition     = output.created_date_time == "2026-01-01T00:00:00Z"
    error_message = "The created date must come from the read."
  }
}

run "never_sends_properties_that_learn_does_not_document_for_create" {
  command = plan

  assert {
    condition     = length(setsubtract(keys(msgraph_resource.extension.body), ["displayName", "description", "endpointConfiguration", "authenticationConfiguration", "clientConfiguration", "callbackConfiguration"])) == 0
    error_message = "replyMode, createdBy and the other read-only or undocumented properties must not be sent."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.extension.body.endpointConfiguration), "authorizedApps") && !contains(keys(msgraph_resource.extension.body), "replyMode")
    error_message = "authorizedApps and replyMode must not be sent."
  }
}

run "callback_duration_adds_the_callback_configuration" {
  command = apply

  variables {
    callback_timeout_duration = "PT45M"
  }

  assert {
    condition = jsonencode(msgraph_resource.extension.body.callbackConfiguration) == jsonencode({
      "@odata.type"   = "#microsoft.graph.identityGovernance.customTaskExtensionCallbackConfiguration"
      timeoutDuration = "PT45M"
    })
    error_message = "A callback duration must be sent in the callbackConfiguration of its documented type."
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.reply_mode == "callback"
    error_message = "Adding a callback duration must update in place and derive the callback reply mode."
  }
}

run "client_configuration_inputs_are_sent_when_set" {
  command = apply

  variables {
    callback_timeout_duration = "PT3H"
    timeout_in_milliseconds   = 2000
    maximum_retries           = 0
  }

  assert {
    condition     = msgraph_resource.extension.body.clientConfiguration.timeoutInMilliseconds == 2000 && msgraph_resource.extension.body.clientConfiguration.maximumRetries == 0
    error_message = "A retry count of zero must be sent, not dropped as if it were null."
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "Changing the client configuration must update in place."
  }
}

run "changing_the_logic_app_and_authentication_updates_in_place" {
  command = apply

  variables {
    logic_app = {
      subscription_id         = "33333333-3333-4333-8333-333333333333"
      resource_group_name     = "rg-other"
      logic_app_workflow_name = "other-logic-app"
    }
    authentication_resource_id = "44444444-4444-4444-8444-444444444444"
  }

  assert {
    condition     = msgraph_resource.extension.body.endpointConfiguration.logicAppWorkflowName == "other-logic-app" && msgraph_resource.extension.body.authenticationConfiguration.resourceId == "44444444-4444-4444-8444-444444444444"
    error_message = "A new endpoint and application must reach the body."
  }

  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "Learn documents the endpoint and authentication configuration for PATCH, so changing them must not replace the extension."
  }
}

run "removing_the_callback_duration_drops_the_callback_configuration" {
  command = plan

  assert {
    condition     = !contains(keys(msgraph_resource.extension.body), "callbackConfiguration")
    error_message = "Clearing the duration must leave no callbackConfiguration in the body."
  }
}
