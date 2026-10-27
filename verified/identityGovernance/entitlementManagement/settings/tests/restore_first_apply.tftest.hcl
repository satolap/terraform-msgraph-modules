# Restoring before any snapshot exists captures the settings as read and sends the owned part
# back, so nothing changes. Fresh state, separate from the other files.

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
          externalUserLifecycleAction                  = "blockSignIn"
          durationUntilExternalUserDeletedAfterBlocked = null
        }
      }
    }
  }
}

run "restore_on_first_apply_is_a_no_op" {
  command = apply

  variables {
    external_user_lifecycle_action = "none"
    restore_previous_state         = true
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "blockSignIn" })
    error_message = "A restore without an earlier snapshot must send the setting as just read."
  }
}
