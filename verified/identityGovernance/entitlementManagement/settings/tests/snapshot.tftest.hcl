# The snapshot is taken from the first read and kept; restore_previous_state PATCHes the owned
# part of it. The runs share one state, so they run in this order.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        settings = {
          "@odata.context"                             = "https://graph.microsoft.com/v1.0/$metadata#identityGovernance/entitlementManagement/settings/$entity"
          id                                           = "settings"
          externalUserLifecycleAction                  = "blockSignIn"
          durationUntilExternalUserDeletedAfterBlocked = "P14D"
        }
      }
    }
  }

  mock_resource "msgraph_update_resource" {
    defaults = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "blockSignInAndDelete"
          durationUntilExternalUserDeletedAfterBlocked = "P30D"
        }
      }
    }
  }
}

variables {
  external_user_lifecycle_action                     = "blockSignInAndDelete"
  duration_until_external_user_deleted_after_blocked = "P30D"
  allow_external_user_deletion                       = true
}

run "first_apply_captures_a_cleaned_snapshot_of_both_settings" {
  command = apply

  assert {
    condition = jsonencode(output.previous_state) == jsonencode({
      durationUntilExternalUserDeletedAfterBlocked = "P14D"
      externalUserLifecycleAction                  = "blockSignIn"
    })
    error_message = "The snapshot must hold both settings only, without id or OData annotations."
  }
}

run "a_later_read_never_overwrites_the_snapshot" {
  command = apply

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
    condition     = output.previous_state.externalUserLifecycleAction == "blockSignIn" && output.previous_state.durationUntilExternalUserDeletedAfterBlocked == "P14D"
    error_message = "The snapshot must stay the state captured before the module first wrote."
  }
}

run "restore_sends_the_owned_part_of_the_snapshot" {
  command = apply

  variables {
    restore_previous_state = true
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ durationUntilExternalUserDeletedAfterBlocked = "P14D", externalUserLifecycleAction = "blockSignIn" })
    error_message = "restore_previous_state = true must PATCH the snapshot values of the owned properties."
  }

  assert {
    condition     = msgraph_update_resource.this.update_method == "PATCH"
    error_message = "The restore is a PATCH of owned properties, never a full replacement."
  }
}

# A snapshot that holds blockSignIn restores without the deletion acknowledgement, because
# the restore writes a value that deletes nothing. A snapshot that holds blockSignInAndDelete
# needs it (restore_delete_snapshot.tftest.hcl).
run "restoring_a_non_deleting_snapshot_needs_no_acknowledgement" {
  command = apply

  variables {
    restore_previous_state       = true
    allow_external_user_deletion = false
  }

  assert {
    condition     = msgraph_update_resource.this.body.externalUserLifecycleAction == "blockSignIn"
    error_message = "A restore must apply without the deletion acknowledgement."
  }
}

run "restore_leaves_unowned_settings_alone" {
  command = apply

  # The input differs from the snapshot value, so only a restore can produce blockSignIn.
  variables {
    restore_previous_state                             = true
    external_user_lifecycle_action                     = "none"
    duration_until_external_user_deleted_after_blocked = null
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "blockSignIn" })
    error_message = "A restore sends the snapshot value, not the input, and a setting whose input is null is not owned and must not be restored."
  }
}

run "leaving_restore_returns_to_the_inputs" {
  command = apply

  assert {
    condition     = msgraph_update_resource.this.body.externalUserLifecycleAction == "blockSignInAndDelete"
    error_message = "With restore_previous_state back to false the inputs apply again."
  }

  assert {
    condition     = output.previous_state.externalUserLifecycleAction == "blockSignIn"
    error_message = "The snapshot survives the restore."
  }
}
