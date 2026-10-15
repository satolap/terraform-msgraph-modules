# Custom extension bindings on the policy. The mock returns one default for every
# data source: the access package read, the catalog extension list and the check's
# read of the policy each use the keys they export. A run overrides what it changes.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        catalog_id = "99999999-9999-9999-9999-999999999999"
        extension_ids = [
          "cccccccc-cccc-cccc-cccc-cccccccccccc",
          "dddddddd-dddd-dddd-dddd-dddddddddddd",
        ]
        custom_extension_stage_settings = []
      }
    }
  }
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"
}

# The key is always sent (owner decision: the module is authoritative over the
# bindings of every policy it manages), so a policy without bindings sends [].
run "sends_an_empty_list_by_default" {
  command = apply

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == "[]"
    error_message = "customExtensionStageSettings must be sent as an empty list when no binding is declared."
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.read_query_parameters) == jsonencode({ "$expand" = ["customExtensionStageSettings($expand=customExtension)"] })
    error_message = "The read must expand the stage settings and their extension; a plain GET does not return them."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.response_export_values.custom_extension_stage_settings == "customExtensionStageSettings[].{stage: stage, extension_id: customExtension.id}"
    error_message = "The read-back must export the stage and the extension id of every binding."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.update_method == "PUT" && msgraph_resource.assignment_policy.api_version == "v1.0"
    error_message = "The policy must still be updated with PUT on v1.0."
  }

  assert {
    condition     = length(data.msgraph_resource.access_package) == 0 && length(data.msgraph_resource.catalog_extensions) == 0
    error_message = "A policy without bindings must not read the access package or the catalog's extensions."
  }

  assert {
    condition     = output.custom_extension_stage_settings != null && jsonencode(output.custom_extension_stage_settings) == "[]"
    error_message = "An empty read-back must be returned as an empty list, not as null."
  }
}

run "sends_the_beta_api_version_the_same_way" {
  command = apply

  variables {
    api_version = "beta"
    expiration  = { type = "afterDuration", duration_days = 30 }
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == jsonencode([{ stage = "assignmentRequestGranted", customExtension = { "@odata.type" = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension", id = "cccccccc-cccc-cccc-cccc-cccccccccccc" } }])
    error_message = "The beta api_version must send the same stage settings."
  }

  assert {
    condition     = data.msgraph_resource.access_package[0].api_version == "beta" && data.msgraph_resource.catalog_extensions[0].api_version == "beta"
    error_message = "The guard reads must use the module's api_version."
  }
}

run "sends_each_declared_binding_with_its_concrete_type" {
  command = apply

  variables {
    expiration = { type = "afterDuration", duration_days = 30 }
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
      { stage = "assignmentFourteenDaysBeforeExpiration", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd", extension_type = "assignment_workflow" },
    ]
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == jsonencode([
      { stage = "assignmentRequestCreated", customExtension = { "@odata.type" = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension", id = "cccccccc-cccc-cccc-cccc-cccccccccccc" } },
      { stage = "assignmentRequestGranted", customExtension = { "@odata.type" = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension", id = "cccccccc-cccc-cccc-cccc-cccccccccccc" } },
      { stage = "assignmentFourteenDaysBeforeExpiration", customExtension = { "@odata.type" = "#microsoft.graph.accessPackageAssignmentWorkflowExtension", id = "dddddddd-dddd-dddd-dddd-dddddddddddd" } },
    ])
    error_message = "Every binding must be sent as { stage, customExtension = { @odata.type, id } } in the declared order, with the concrete extension type."
  }

  assert {
    condition     = length(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == 3
    error_message = "One extension under two stages must produce two entries."
  }

  assert {
    condition     = data.msgraph_resource.access_package[0].url == "identityGovernance/entitlementManagement/accessPackages/77777777-7777-7777-7777-777777777777" && jsonencode(data.msgraph_resource.access_package[0].query_parameters) == jsonencode({ "$expand" = ["catalog"] })
    error_message = "The access package must be read with its catalog expanded."
  }

  assert {
    condition     = data.msgraph_resource.catalog_extensions[0].url == "identityGovernance/entitlementManagement/catalogs/99999999-9999-9999-9999-999999999999/customWorkflowExtensions"
    error_message = "The extensions must be listed from the catalog of the access package."
  }
}

run "sends_the_same_extension_under_granted_and_removed" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD", extension_type = "request_workflow" },
      { stage = "assignmentRequestRemoved", extension_id = "DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD", extension_type = "request_workflow" },
    ]
  }

  assert {
    condition     = length(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == 2
    error_message = "One extension may be bound to several stages, and a GUID in upper case must be accepted and found in the catalog."
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.customExtensionStageSettings[1].customExtension.id == "dddddddd-dddd-dddd-dddd-dddddddddddd"
    error_message = "The extension id must be sent in lower case, as Graph returns it, because the provider compares the read-back case-sensitively."
  }
}

# The check reads the policy again and warns, per policy, about the bindings that
# the next apply removes. A run that must warn lists the check in expect_failures.
run "warns_about_bindings_that_the_configuration_does_not_declare" {
  command = apply

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = [
          { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc" },
        ]
      }
    }
  }

  expect_failures = [check.undeclared_custom_extension_bindings]
}

run "does_not_warn_when_every_server_binding_is_declared" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = [
          { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc" },
        ]
      }
    }
  }
}

run "warns_when_the_server_binds_another_extension_to_a_declared_stage" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = [
          { stage = "assignmentRequestCreated", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd" },
        ]
      }
    }
  }

  expect_failures = [check.undeclared_custom_extension_bindings]
}

# The provider always writes the exported key: with a null value when Graph omits it
# or returns null. The check must treat that null like an empty list, with and
# without declared bindings. A run with no key at all stays, for a mock that omits it.
run "does_not_warn_when_graph_did_not_return_the_bindings" {
  command = apply

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {}
    }
  }
}

run "does_not_warn_when_graph_returns_the_bindings_as_null" {
  command = apply

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = null
      }
    }
  }
}

run "does_not_warn_when_graph_returns_the_bindings_as_null_next_to_declared_ones" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = null
      }
    }
  }
}

# Graph documents customExtension as nullable, so a binding can come back without an
# extension. The check still names the stage and warns; it must not fail the apply
# that would remove the binding.
run "warns_about_a_server_binding_without_an_extension" {
  command = apply

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = [
          { stage = "assignmentRequestGranted", extension_id = null },
        ]
      }
    }
  }

  expect_failures = [check.undeclared_custom_extension_bindings]
}

run "warns_about_a_server_binding_without_an_extension_next_to_declared_ones" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = [
          { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc" },
          { stage = "assignmentRequestRemoved", extension_id = null },
        ]
      }
    }
  }

  expect_failures = [check.undeclared_custom_extension_bindings]
}

# A read-back that mixes a declared binding, one without an extension and one
# without a stage still warns instead of failing the apply.
run "warns_about_a_mixed_read_back_with_a_null_extension_and_a_null_stage" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.server_bindings
    values = {
      output = {
        custom_extension_stage_settings = [
          { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc" },
          { stage = "assignmentRequestGranted", extension_id = null },
          { stage = null, extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd" },
        ]
      }
    }
  }

  expect_failures = [check.undeclared_custom_extension_bindings]
}

# Guests and external users: the tenant needs the Azure subscription link, and
# each successful request is billed. The check warns; it never fails the plan.
run "warns_for_a_guest_scope_with_bindings" {
  command = apply

  variables {
    allowed_target_scope = "allExternalUsers"
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [check.guest_custom_extension_prerequisite]
}

run "warns_for_connected_organization_users_with_bindings" {
  command = apply

  variables {
    allowed_target_scope     = "specificConnectedOrganizationUsers"
    specific_allowed_targets = [{ type = "connectedOrganizationMembers", id = "55555555-5555-5555-5555-555555555555" }]
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [check.guest_custom_extension_prerequisite]
}

run "warns_for_all_configured_connected_organization_users_with_bindings" {
  command = apply

  variables {
    allowed_target_scope = "allConfiguredConnectedOrganizationUsers"
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [check.guest_custom_extension_prerequisite]
}

run "warns_for_all_directory_users_with_bindings" {
  command = apply

  variables {
    allowed_target_scope = "allDirectoryUsers"
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [check.guest_custom_extension_prerequisite]
}

# A user, group or dynamic rule that the policy names can be or contain a guest.
run "warns_for_specific_directory_users_with_targets_and_bindings" {
  command = apply

  variables {
    allowed_target_scope     = "specificDirectoryUsers"
    specific_allowed_targets = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [check.guest_custom_extension_prerequisite]
}

run "does_not_warn_for_specific_directory_users_without_targets" {
  command = apply

  variables {
    allowed_target_scope = "specificDirectoryUsers"
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }
}

run "does_not_warn_for_member_users_with_bindings" {
  command = apply

  variables {
    allowed_target_scope = "allMemberUsers"
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }
}

run "does_not_warn_for_a_guest_scope_without_bindings" {
  command = apply

  variables {
    allowed_target_scope = "allExternalUsers"
  }
}

# Validations on the input. expect_failures does not read the message, so
# tests/test_assignment_policy_custom_extensions.py checks the wording.
run "rejects_an_unknown_stage" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestDenied", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

run "rejects_the_unknown_future_value_stage" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "unknownFutureValue", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

run "rejects_an_unknown_extension_type" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "accessPackageAssignmentRequestWorkflowExtension" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

run "rejects_a_request_stage_with_an_assignment_workflow_extension" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestApproved", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "assignment_workflow" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

run "rejects_an_expiration_stage_with_a_request_workflow_extension" {
  command = plan

  variables {
    expiration = { type = "afterDuration", duration_days = 30 }
    custom_extension_stage_settings = [
      { stage = "assignmentOneDayBeforeExpiration", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

run "rejects_a_stage_that_is_declared_twice" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
      { stage = "assignmentRequestGranted", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

run "rejects_an_extension_id_that_is_not_a_guid" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "not-a-guid", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

run "rejects_an_empty_extension_id" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [var.custom_extension_stage_settings]
}

# nullable = false: a null from a caller means the default, so it cannot unset the key.
run "treats_a_null_list_as_the_default" {
  command = apply

  variables {
    custom_extension_stage_settings = null
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == "[]"
    error_message = "A null list must send [] like the default, never omit the key."
  }
}

# Guards on the resource. A plan that fails a precondition stops before the checks run.
run "rejects_an_expiration_stage_when_assignments_never_expire" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentOneDayBeforeExpiration", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd", extension_type = "assignment_workflow" },
    ]
  }

  expect_failures = [msgraph_resource.assignment_policy]
}

run "accepts_an_expiration_stage_when_assignments_expire_after_a_date" {
  command = apply

  variables {
    expiration = { type = "afterDateTime", end_date_time = "2030-01-01T00:00:00Z" }
    custom_extension_stage_settings = [
      { stage = "assignmentFourteenDaysBeforeExpiration", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd", extension_type = "assignment_workflow" },
    ]
  }

  assert {
    condition     = length(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == 1
    error_message = "An expiration stage must be accepted when the policy expires assignments."
  }
}

run "accepts_a_request_stage_when_assignments_never_expire" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.expiration.type == "noExpiration"
    error_message = "A request stage must be accepted whatever the expiration is."
  }
}

run "rejects_an_extension_that_is_not_in_the_catalog" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [msgraph_resource.assignment_policy]
}

run "rejects_one_missing_extension_among_declared_ones" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
      { stage = "assignmentRequestGranted", extension_id = "eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [msgraph_resource.assignment_policy]
}

run "rejects_every_extension_when_the_catalog_has_none" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.catalog_extensions
    values = {
      output = {
        extension_ids = []
      }
    }
  }

  expect_failures = [msgraph_resource.assignment_policy]
}

run "rejects_bindings_when_the_catalog_list_is_missing" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.catalog_extensions
    values = {
      output = {}
    }
  }

  expect_failures = [msgraph_resource.assignment_policy]
}

# The provider writes a null for a list that Graph did not return, not a missing key.
run "rejects_bindings_when_the_catalog_list_is_null" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.catalog_extensions
    values = {
      output = {
        extension_ids = null
      }
    }
  }

  expect_failures = [msgraph_resource.assignment_policy]
}

# The access package read must return its catalog. Without one the list of the
# catalog's extensions cannot be read, and the guard says so instead of failing on
# a request for an empty catalog id.
run "rejects_bindings_when_the_access_package_has_no_catalog" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.access_package
    values = {
      output = {
        catalog_id = null
      }
    }
  }

  expect_failures = [data.msgraph_resource.catalog_extensions]
}

run "rejects_bindings_when_the_access_package_read_has_no_catalog_key" {
  command = plan

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestGranted", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  override_data {
    target = data.msgraph_resource.access_package
    values = {
      output = {}
    }
  }

  expect_failures = [data.msgraph_resource.catalog_extensions]
}

# An extension and an access package that the same apply creates have ids that are
# unknown at plan time. The helper gives them one through terraform_data. The guards
# must wait for them instead of failing against a list that was read before the
# extension existed, or against a catalog that is not known yet.
run "binds_an_extension_that_the_same_apply_creates" {
  command = apply

  module {
    source = "./tests/unknown_extension"
  }

  assert {
    condition     = output.id == "88888888-8888-8888-8888-888888888888"
    error_message = "A binding to an extension created in the same apply must create the policy."
  }
}
