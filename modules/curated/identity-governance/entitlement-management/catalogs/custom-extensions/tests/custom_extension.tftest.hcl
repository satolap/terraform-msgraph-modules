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

  # By default the catalog holds no other extension.
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        extensions = []
      }
    }
  }
}

variables {
  catalog_id     = "11111111-1111-1111-1111-111111111111"
  extension_type = "request_workflow"
  logic_app = {
    subscription_id     = "33333333-3333-3333-3333-333333333333"
    resource_group_name = "rg-example"
    workflow_name       = "logic-example"
  }
}

# The runs below share one state in file order: the first run creates the
# extension, later runs update or replace it. A replacement takes the id of the
# override_resource block; an in-place update keeps the id in the state.

run "request_workflow_renders_the_full_body" {
  command = apply

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/catalogs/11111111-1111-1111-1111-111111111111/customWorkflowExtensions" && msgraph_resource.this.api_version == "v1.0"
    error_message = "The extension must be created in the catalog's customWorkflowExtensions collection on v1.0."
  }

  assert {
    condition     = msgraph_resource.this.update_method == "PUT"
    error_message = "Microsoft Learn documents only PUT to update the extension, so update_method must be PUT."
  }

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == false
    error_message = "ignore_missing_property must be false so that server-side changes show as drift."
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body) == jsonencode({
      "@odata.type" = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension"
      displayName   = "logic-example"
      description   = null
      endpointConfiguration = {
        "@odata.type"        = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
        subscriptionId       = "33333333-3333-3333-3333-333333333333"
        resourceGroupName    = "rg-example"
        logicAppWorkflowName = "logic-example"
      }
      authenticationConfiguration = {
        "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
      }
    })
    error_message = "The body must carry the request workflow type, the Logic App workflow name as the default display name, a null description, the endpoint without url and proof-of-possession authentication."
  }

  assert {
    condition     = data.msgraph_resource.catalog_extensions.url == "identityGovernance/entitlementManagement/catalogs/11111111-1111-1111-1111-111111111111/customWorkflowExtensions" && data.msgraph_resource.catalog_extensions.api_version == "v1.0"
    error_message = "The catalog's extensions must be listed from the same collection on v1.0."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222" && output.catalog_id == "11111111-1111-1111-1111-111111111111"
    error_message = "id must come from the resource and catalog_id from the input."
  }

  assert {
    condition     = output.extension_type == "request_workflow" && output.odata_type == "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension"
    error_message = "extension_type and its concrete @odata.type must be exposed."
  }

  assert {
    condition     = output.display_name == "logic-example"
    error_message = "display_name must be the effective name, which defaults to the Logic App workflow name."
  }

  assert {
    condition     = output.logic_app_resource_id == "/subscriptions/33333333-3333-3333-3333-333333333333/resourceGroups/rg-example/providers/Microsoft.Logic/workflows/logic-example"
    error_message = "logic_app_resource_id must be the Azure resource id of the Logic App."
  }

  assert {
    condition     = jsonencode(terraform_data.identity.input) == jsonencode({ catalog_id = "11111111-1111-1111-1111-111111111111", extension_type = "request_workflow" })
    error_message = "The replace trigger must hold the extension type and the catalog id, the two values an update cannot change."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.timeouts) == jsonencode({ create = "10m", delete = "10m", read = null, update = "10m" })
    error_message = "With default inputs the create, update and delete timeouts must be 10m and read must stay unset."
  }
}

# A caller puts the binding into an assignment policy's stage settings.
run "binding_output_merges_with_a_stage" {
  command = apply

  assert {
    condition     = jsonencode(output.binding) == jsonencode({ extension_id = "22222222-2222-2222-2222-222222222222", extension_type = "request_workflow" })
    error_message = "binding must hold exactly the extension id and its extension type."
  }

  assert {
    condition     = jsonencode(merge(output.binding, { stage = "assignmentRequestGranted" })) == jsonencode({ extension_id = "22222222-2222-2222-2222-222222222222", extension_type = "request_workflow", stage = "assignmentRequestGranted" })
    error_message = "merge(binding, { stage = ... }) must yield one element of the assignment policy's custom_extension_stage_settings."
  }
}

run "description_is_always_sent" {
  command = apply

  variables {
    description = "Notifies the owner"
  }

  assert {
    condition     = msgraph_resource.this.body.description == "Notifies the owner"
    error_message = "A configured description must be sent."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "A description change must update the extension in place and keep its id."
  }
}

# A partial PUT keeps omitted properties, so a description can only be cleared
# by sending it. Whether Microsoft Graph accepts the null is not verified.
run "cleared_description_is_sent_as_null" {
  command = apply

  assert {
    condition     = contains(keys(msgraph_resource.this.body), "description") && msgraph_resource.this.body.description == null
    error_message = "A description that is no longer configured must still be in the body, as null."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Clearing the description must update the extension in place and keep its id."
  }
}

run "trigger_url_is_sent_when_set" {
  command = apply

  variables {
    display_name = "Notify owner"
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?api-version=2016-10-01"
    }
  }

  # A new object would take this id; an in-place update keeps the old one.
  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000001"
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

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "A name and url change must update the extension in place and keep its id."
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body.endpointConfiguration) == jsonencode({
      "@odata.type"        = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
      subscriptionId       = "33333333-3333-3333-3333-333333333333"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "logic-example"
      url                  = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?api-version=2016-10-01"
    })
    error_message = "The trigger url must be added to the endpoint configuration when it is set."
  }

  assert {
    condition     = msgraph_resource.this.body.displayName == "Notify owner" && output.display_name == "Notify owner"
    error_message = "A configured display name must replace the default."
  }
}

run "trigger_url_is_left_out_when_removed" {
  command = apply

  variables {
    display_name = "Notify owner"
  }

  assert {
    condition     = !contains(keys(msgraph_resource.this.body.endpointConfiguration), "url")
    error_message = "Without trigger_url the endpoint configuration must not contain a url key."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Removing the url must update the extension in place and keep its id."
  }
}

run "changing_the_extension_type_replaces_the_extension" {
  command = apply

  variables {
    extension_type = "assignment_workflow"
    description    = "Warns before expiry"
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?api-version=2016-10-01"
    }
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000002"
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

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000002"
    error_message = "A new extension type must replace the extension, so the new object's id is used."
  }

  assert {
    condition     = output.extension_type == "assignment_workflow" && output.odata_type == "#microsoft.graph.accessPackageAssignmentWorkflowExtension" && msgraph_resource.this.body["@odata.type"] == "#microsoft.graph.accessPackageAssignmentWorkflowExtension"
    error_message = "The assignment workflow type must map to its concrete @odata.type in the body and the outputs."
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body) == jsonencode({
      "@odata.type" = "#microsoft.graph.accessPackageAssignmentWorkflowExtension"
      displayName   = "logic-example"
      description   = "Warns before expiry"
      endpointConfiguration = {
        "@odata.type"        = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
        subscriptionId       = "33333333-3333-3333-3333-333333333333"
        resourceGroupName    = "rg-example"
        logicAppWorkflowName = "logic-example"
        url                  = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?api-version=2016-10-01"
      }
      authenticationConfiguration = {
        "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
      }
    })
    error_message = "The assignment workflow body must have the same shape, with its own @odata.type."
  }

  assert {
    condition     = jsonencode(output.binding) == jsonencode({ extension_id = "22222222-2222-2222-2222-000000000002", extension_type = "assignment_workflow" })
    error_message = "The binding must follow the replacement."
  }

  assert {
    condition     = jsonencode(terraform_data.identity.input) == jsonencode({ catalog_id = "11111111-1111-1111-1111-111111111111", extension_type = "assignment_workflow" })
    error_message = "The replace trigger must follow the extension type."
  }
}

run "changing_the_catalog_replaces_the_extension" {
  command = apply

  variables {
    catalog_id     = "44444444-4444-4444-4444-444444444444"
    extension_type = "assignment_workflow"
    description    = "Warns before expiry"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000003"
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

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000003"
    error_message = "A new catalog must replace the extension, because an update cannot move it to another catalog."
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/catalogs/44444444-4444-4444-4444-444444444444/customWorkflowExtensions" && output.catalog_id == "44444444-4444-4444-4444-444444444444"
    error_message = "The replacement must be created in the new catalog."
  }

  assert {
    condition     = jsonencode(terraform_data.identity.input) == jsonencode({ catalog_id = "44444444-4444-4444-4444-444444444444", extension_type = "assignment_workflow" })
    error_message = "The replace trigger must follow the catalog id."
  }
}

# unique_display_name. The state holds the id of the previous run's replacement.
run "does_not_report_itself_or_extensions_of_another_type_or_name" {
  command = apply

  variables {
    catalog_id     = "44444444-4444-4444-4444-444444444444"
    extension_type = "assignment_workflow"
    description    = "Warns before expiry"
  }

  override_data {
    target = data.msgraph_resource.catalog_extensions
    values = {
      output = {
        extensions = [
          { id = "22222222-2222-2222-2222-000000000003", odata_type = "#microsoft.graph.accessPackageAssignmentWorkflowExtension", display_name = "logic-example" },
          { id = "55555555-5555-5555-5555-555555555555", odata_type = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension", display_name = "logic-example" },
          { id = "66666666-6666-6666-6666-666666666666", odata_type = "#microsoft.graph.accessPackageAssignmentWorkflowExtension", display_name = "another-name" },
        ]
      }
    }
  }

  assert {
    condition     = length(local.duplicate_extension_ids) == 0
    error_message = "The extension itself, an extension of the other type and an extension with another name are not duplicates."
  }
}

run "warns_when_another_extension_of_the_same_type_has_the_name" {
  command = apply

  variables {
    catalog_id     = "44444444-4444-4444-4444-444444444444"
    extension_type = "assignment_workflow"
    description    = "Warns before expiry"
  }

  override_data {
    target = data.msgraph_resource.catalog_extensions
    values = {
      output = {
        extensions = [
          { id = "22222222-2222-2222-2222-000000000003", odata_type = "#microsoft.graph.accessPackageAssignmentWorkflowExtension", display_name = "logic-example" },
          { id = "77777777-7777-7777-7777-777777777777", odata_type = "#microsoft.graph.accessPackageAssignmentWorkflowExtension", display_name = "logic-example" },
        ]
      }
    }
  }

  expect_failures = [check.unique_display_name]

  assert {
    condition     = jsonencode(local.duplicate_extension_ids) == jsonencode(["77777777-7777-7777-7777-777777777777"])
    error_message = "The other extension with the same type and name must be reported by its id."
  }
}

# unmanaged_properties. The override replaces the read-back object, so a mock
# provider never evaluates the JMESPath keys that produce it; a static check in
# the Python suite ties them to the mapping.
run "reports_no_unmanaged_property_when_graph_returns_none" {
  command = apply

  variables {
    catalog_id     = "44444444-4444-4444-4444-444444444444"
    extension_type = "assignment_workflow"
    description    = "Warns before expiry"
  }

  assert {
    condition     = length(local.unmanaged_set) == 0
    error_message = "A read-back without unmanaged properties set must report none, and the check must not warn."
  }
}

run "reports_every_unmanaged_property_that_graph_returns_set" {
  command = apply

  # A mock in-place update keeps the last read-back, so move the extension back
  # to the first catalog: the replacement takes the override's read-back.
  variables {
    extension_type = "assignment_workflow"
    description    = "Warns before expiry"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000004"
      output = {
        unmanaged_properties = {
          callback_configuration = true
          client_configuration   = true
          behavior_on_error      = true
          other_authentication   = true
        }
      }
    }
  }

  expect_failures = [check.unmanaged_properties]

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000004"
    error_message = "A new catalog must replace the extension, so the new object's read-back is used."
  }

  assert {
    condition     = jsonencode(local.unmanaged_set) == jsonencode(["authenticationConfiguration", "behaviorOnError", "callbackConfiguration", "clientConfiguration"])
    error_message = "Every unmanaged property that Graph returned set must be reported by its name, sorted."
  }
}

# name_pattern
run "accepts_a_display_name_that_matches_the_pattern" {
  command = apply

  variables {
    catalog_id   = "44444444-4444-4444-4444-444444444444"
    display_name = "notify-owner"
    name_pattern = "^notify-"
  }

  assert {
    condition     = output.display_name == "notify-owner"
    error_message = "A display name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_the_pattern" {
  command = plan

  variables {
    catalog_id   = "44444444-4444-4444-4444-444444444444"
    display_name = "owner-notice"
    name_pattern = "^notify-"
  }

  expect_failures = [msgraph_resource.this]
}

run "applies_the_pattern_to_the_default_display_name" {
  command = plan

  variables {
    catalog_id   = "44444444-4444-4444-4444-444444444444"
    name_pattern = "^notify-"
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    catalog_id   = "44444444-4444-4444-4444-444444444444"
    name_pattern = "(unclosed"
  }

  expect_failures = [var.name_pattern]
}

# logic_app_id_length. The prefix and suffix of the id take 104 characters, so
# 46 characters of group and workflow names make 150.
run "accepts_a_logic_app_id_of_150_characters" {
  command = apply

  variables {
    catalog_id = "44444444-4444-4444-4444-444444444444"
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rrrrrrrrrrrrrrrrrrrrrrr"
      workflow_name       = "wwwwwwwwwwwwwwwwwwwwwww"
    }
  }

  assert {
    condition     = length(output.logic_app_resource_id) == 150
    error_message = "The fixture must compose a 150 character id."
  }
}

run "warns_about_a_logic_app_id_over_150_characters" {
  command = apply

  variables {
    catalog_id = "44444444-4444-4444-4444-444444444444"
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rrrrrrrrrrrrrrrrrrrrrrrr"
      workflow_name       = "wwwwwwwwwwwwwwwwwwwwwww"
    }
  }

  expect_failures = [check.logic_app_id_length]

  assert {
    condition     = length(output.logic_app_resource_id) == 151
    error_message = "The fixture must compose a 151 character id."
  }
}

# Validation. Each run changes one input and expects its variable to fail.
run "rejects_a_catalog_id_that_is_not_a_guid" {
  command = plan

  variables {
    catalog_id = "not-a-guid"
  }

  expect_failures = [var.catalog_id]
}

run "rejects_an_empty_catalog_id" {
  command = plan

  variables {
    catalog_id = ""
  }

  expect_failures = [var.catalog_id]
}

run "rejects_an_unknown_extension_type" {
  command = plan

  variables {
    extension_type = "accessPackageAssignmentRequestWorkflowExtension"
  }

  expect_failures = [var.extension_type]
}

run "rejects_a_subscription_id_that_is_not_a_guid" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "subscription"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_an_empty_resource_group_name" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = ""
      workflow_name       = "logic-example"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_resource_group_name_with_a_slash" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg/example"
      workflow_name       = "logic-example"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_an_empty_workflow_name" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = ""
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_workflow_name_with_a_slash" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic/example"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_null_subscription_id" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = null
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
    }
  }

  expect_failures = [var.logic_app]
}

# A null name must reach the validation message, not a function error. Terraform
# 1.7.5 evaluates the right operand of && even when the left one is false (1.16.2
# skips it), so trimspace() would fail on the null before the message is shown.
run "rejects_a_null_resource_group_name" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = null
      workflow_name       = "logic-example"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_null_workflow_name" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = null
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_trigger_url_without_https" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "http://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?api-version=2016-10-01"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_trigger_url_that_is_not_a_trigger" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111?api-version=2016-10-01"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_trigger_url_with_a_signature" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?api-version=2016-10-01&sig=placeholder"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_trigger_url_with_a_sas_permission" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?sp=%2Ftriggers%2Fmanual%2Frun&api-version=2016-10-01"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_trigger_url_with_a_sas_version" {
  command = plan

  variables {
    logic_app = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      resource_group_name = "rg-example"
      workflow_name       = "logic-example"
      trigger_url         = "https://prod-00.westeurope.logic.azure.com:443/workflows/11111111111111111111111111111111/triggers/manual/paths/invoke?api-version=2016-10-01&SV=1.0"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_an_empty_display_name" {
  command = plan

  variables {
    display_name = ""
  }

  expect_failures = [var.display_name]
}

run "rejects_a_blank_display_name" {
  command = plan

  variables {
    display_name = "   "
  }

  expect_failures = [var.display_name]
}

run "applies_custom_timeouts" {
  command = apply

  variables {
    timeouts = { create = "30m", read = "5m", update = "20m", delete = "25m" }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.timeouts) == jsonencode({ create = "30m", delete = "25m", read = "5m", update = "20m" })
    error_message = "Each configured timeout must be planned as given."
  }
}

# A wrapper that forwards an unset variable passes null; the module must use the
# defaults, as it does when timeouts is unset.
run "null_timeouts_use_the_defaults" {
  command = apply

  variables {
    timeouts = null
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.timeouts) == jsonencode({ create = "10m", delete = "10m", read = null, update = "10m" })
    error_message = "A null timeouts must use the create, update and delete defaults of 10m and leave read unset."
  }
}

run "rejects_malformed_timeout" {
  command = plan

  variables {
    timeouts = { update = "10 minutes" }
  }

  expect_failures = [var.timeouts]
}

# The provider accepts a zero duration; the module does not. read has no minimum,
# so only the zero rule rejects it.
run "rejects_zero_timeout" {
  command = plan

  variables {
    timeouts = { read = "0s" }
  }

  expect_failures = [var.timeouts]
}

# The provider waits at least 10 seconds for three consistent reads after a write.
run "rejects_short_timeout" {
  command = plan

  variables {
    timeouts = { update = "14s" }
  }

  expect_failures = [var.timeouts]
}

# The minimum itself is accepted.
run "accepts_15_second_timeouts" {
  command = apply

  variables {
    timeouts = { create = "15s", update = "15s", delete = "15s" }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.timeouts) == jsonencode({ create = "15s", delete = "15s", read = null, update = "15s" })
    error_message = "15s is the documented minimum for create, update and delete and must be accepted."
  }
}

# A GUID has no case. The module lower-cases the catalog id for the url and for
# the replace trigger, so a change of case alone neither replaces the extension
# nor plans a change to it. These two runs end the file because they move the
# shared state to a catalog with letters in its id.
run "a_lower_case_catalog_id_is_used_as_given" {
  command = apply

  variables {
    catalog_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000010"
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

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000010"
    error_message = "A new catalog must replace the extension."
  }

  assert {
    condition     = jsonencode(terraform_data.identity.input) == jsonencode({ catalog_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", extension_type = "request_workflow" })
    error_message = "The replace trigger must hold the catalog id in lower case."
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/catalogs/aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/customWorkflowExtensions" && data.msgraph_resource.catalog_extensions.url == "identityGovernance/entitlementManagement/catalogs/aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/customWorkflowExtensions"
    error_message = "The extension and the listing must use the catalog id in lower case."
  }

  assert {
    condition     = output.catalog_id == "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
    error_message = "catalog_id must be exposed in lower case."
  }
}

run "an_upper_case_catalog_id_gives_the_same_replace_trigger_and_url" {
  command = apply

  variables {
    catalog_id = "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE"
  }

  # Used only if the extension were replaced.
  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000011"
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

  assert {
    condition     = output.id == "22222222-2222-2222-2222-000000000010"
    error_message = "A change of case in catalog_id must not replace the extension."
  }

  assert {
    condition     = jsonencode(terraform_data.identity.input) == jsonencode({ catalog_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", extension_type = "request_workflow" })
    error_message = "An upper case and a lower case catalog_id must give the same replace trigger."
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/catalogs/aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/customWorkflowExtensions" && data.msgraph_resource.catalog_extensions.url == "identityGovernance/entitlementManagement/catalogs/aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/customWorkflowExtensions"
    error_message = "An upper case catalog_id must give the same url, so a change of case plans no change."
  }

  assert {
    condition     = output.catalog_id == "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee" && output.binding.extension_id == "22222222-2222-2222-2222-000000000010"
    error_message = "The outputs must not change with the case of catalog_id."
  }
}
