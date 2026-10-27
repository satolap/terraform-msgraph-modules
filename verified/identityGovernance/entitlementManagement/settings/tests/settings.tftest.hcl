# Fixtures follow the entitlementManagementSettings resource and the Update reference of
# Microsoft Graph v1.0: the singleton is read with GET and written with a partial PATCH.
# https://learn.microsoft.com/graph/api/resources/entitlementmanagementsettings?view=graph-rest-1.0
# https://learn.microsoft.com/graph/api/entitlementmanagementsettings-update?view=graph-rest-1.0
# Mocks establish the module's request shape only, not tenant behaviour.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        settings = {
          "@odata.context"                             = "https://graph.microsoft.com/v1.0/$metadata#identityGovernance/entitlementManagement/settings/$entity"
          id                                           = "settings"
          externalUserLifecycleAction                  = "blockSignIn"
          durationUntilExternalUserDeletedAfterBlocked = null
        }
      }
    }
  }

  mock_resource "msgraph_update_resource" {
    defaults = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "none"
          durationUntilExternalUserDeletedAfterBlocked = null
        }
      }
    }
  }
}

variables {
  external_user_lifecycle_action = "none"
}

run "reads_the_singleton" {
  command = plan

  assert {
    condition     = data.msgraph_resource.settings.url == "identityGovernance/entitlementManagement/settings" && data.msgraph_resource.settings.api_version == "v1.0"
    error_message = "The module must read the entitlementManagementSettings singleton from v1.0."
  }
}

run "partial_update_sends_only_the_owned_property" {
  command = plan

  assert {
    condition     = msgraph_update_resource.this.url == "identityGovernance/entitlementManagement/settings" && msgraph_update_resource.this.api_version == "v1.0"
    error_message = "The module must write the singleton at v1.0."
  }

  assert {
    condition     = msgraph_update_resource.this.update_method == "PATCH"
    error_message = "The update must be a partial PATCH."
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "none" })
    error_message = "A null duration input must be omitted, not sent as null, empty or a default."
  }

  assert {
    condition     = jsonencode(output.owned_properties) == jsonencode(["externalUserLifecycleAction"])
    error_message = "Only the property with a non-null input is owned."
  }
}

run "body_never_carries_read_only_values" {
  command = plan

  assert {
    condition     = !contains(keys(msgraph_update_resource.this.body), "id") && !contains(keys(msgraph_update_resource.this.body), "@odata.type")
    error_message = "The read-only id and OData annotations must never be sent."
  }
}

run "a_differing_value_is_reported_as_drift" {
  command = plan

  assert {
    condition     = jsonencode(output.drifted_properties) == jsonencode(["externalUserLifecycleAction"])
    error_message = "The tenant holds blockSignIn and the input is none, so the property must be listed as drifted."
  }
}

run "a_matching_value_is_a_no_op" {
  command = plan

  variables {
    external_user_lifecycle_action = "blockSignIn"
  }

  assert {
    condition     = length(output.drifted_properties) == 0
    error_message = "A value equal to the tenant's must list no drift."
  }
}

run "the_enum_comparison_is_exact_like_the_providers" {
  command = plan

  variables {
    external_user_lifecycle_action = "blockSignIn"
  }

  override_data {
    target = data.msgraph_resource.settings
    values = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "BlockSignIn"
          durationUntilExternalUserDeletedAfterBlocked = null
        }
      }
    }
  }

  assert {
    condition     = jsonencode(output.drifted_properties) == jsonencode(["externalUserLifecycleAction"])
    error_message = "A tenant that returns another spelling of the enum must show as drift, because the provider compares exactly and would plan an update on every run."
  }
}

run "delete_action_with_duration_and_acknowledgement" {
  command = plan

  variables {
    external_user_lifecycle_action                     = "blockSignInAndDelete"
    duration_until_external_user_deleted_after_blocked = "P30D"
    allow_external_user_deletion                       = true
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ durationUntilExternalUserDeletedAfterBlocked = "P30D", externalUserLifecycleAction = "blockSignInAndDelete" })
    error_message = "Both owned properties must be sent."
  }

  assert {
    condition     = jsonencode(output.owned_properties) == jsonencode(["durationUntilExternalUserDeletedAfterBlocked", "externalUserLifecycleAction"])
    error_message = "Both properties must be owned."
  }
}

run "duration_only_update_is_a_partial_update" {
  command = plan

  variables {
    external_user_lifecycle_action                     = "blockSignInAndDelete"
    duration_until_external_user_deleted_after_blocked = "P90D"
    allow_external_user_deletion                       = true
  }

  override_data {
    target = data.msgraph_resource.settings
    values = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "blockSignInAndDelete"
          durationUntilExternalUserDeletedAfterBlocked = "P30D"
        }
      }
    }
  }

  assert {
    condition     = jsonencode(output.drifted_properties) == jsonencode(["durationUntilExternalUserDeletedAfterBlocked"])
    error_message = "Only the duration differs from the tenant, so only it is drifted."
  }
}

run "the_settings_output_is_the_read_back_not_the_input" {
  command = apply

  # The service answers with a value other than the input, so an output that echoed the
  # input would fail.
  override_resource {
    target = msgraph_update_resource.this
    values = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "blockSignIn"
          durationUntilExternalUserDeletedAfterBlocked = null
        }
      }
    }
  }

  assert {
    condition     = output.settings.externalUserLifecycleAction == "blockSignIn" && var.external_user_lifecycle_action == "none"
    error_message = "The settings output must be the read after the apply, not the input."
  }
}

run "no_input_owns_nothing_and_fails" {
  command = plan

  variables {
    external_user_lifecycle_action = null
  }

  expect_failures = [msgraph_update_resource.this]
}
