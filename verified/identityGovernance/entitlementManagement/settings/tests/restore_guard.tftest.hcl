# A restore overwrites only a property that still holds what the inputs apply or the snapshot
# value. The tenant is changed through override_data between runs. One state, in order.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        settings = {
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

run "first_apply" {
  command = apply

  assert {
    condition     = output.previous_state.externalUserLifecycleAction == "blockSignIn"
    error_message = "The snapshot holds the tenant's first value."
  }
}

run "restore_over_a_value_changed_elsewhere_fails" {
  command = plan

  variables {
    restore_previous_state = true
  }

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { externalUserLifecycleAction = "blockSignInAndDelete", durationUntilExternalUserDeletedAfterBlocked = "P7D" } } }
  }

  expect_failures = [msgraph_update_resource.this]
}

# The snapshot holds blockSignIn, so no deletion acknowledgement is needed here.
run "restore_over_changes_is_explicit" {
  command = apply

  variables {
    restore_previous_state = true
    restore_over_changes   = true
  }

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { externalUserLifecycleAction = "blockSignInAndDelete", durationUntilExternalUserDeletedAfterBlocked = "P7D" } } }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "blockSignIn" })
    error_message = "restore_over_changes = true restores the snapshot over the change."
  }
}

run "a_value_that_equals_the_inputs_may_be_restored" {
  command = apply

  variables {
    restore_previous_state = true
  }

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { externalUserLifecycleAction = "none", durationUntilExternalUserDeletedAfterBlocked = null } } }
  }

  assert {
    condition     = msgraph_update_resource.this.body.externalUserLifecycleAction == "blockSignIn"
    error_message = "A value the module last applied is its own to overwrite."
  }
}

run "a_value_that_already_equals_the_snapshot_may_be_restored" {
  command = apply

  variables {
    restore_previous_state = true
  }

  assert {
    condition     = msgraph_update_resource.this.body.externalUserLifecycleAction == "blockSignIn"
    error_message = "A value that already holds the snapshot is not a change by someone else."
  }
}
