# A property that became owned after the first apply is not restored: the snapshot holds only
# a read taken before this module managed it. One state, in order.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "none"
          durationUntilExternalUserDeletedAfterBlocked = "P14D"
        }
      }
    }
  }

  mock_resource "msgraph_update_resource" {
    defaults = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "blockSignIn"
          durationUntilExternalUserDeletedAfterBlocked = "P14D"
        }
      }
    }
  }
}

run "first_apply_owns_only_the_action" {
  command = apply

  variables {
    externalUserLifecycleAction = "blockSignIn"
  }

  assert {
    condition     = jsonencode(output.owned_properties) == jsonencode(["externalUserLifecycleAction"])
    error_message = "Only the action is owned at the first apply."
  }
}

run "the_duration_becomes_owned_later" {
  command = apply

  variables {
    externalUserLifecycleAction                  = "blockSignInAndDelete"
    durationUntilExternalUserDeletedAfterBlocked = "P30D"
    allow_external_user_deletion                 = true
  }

  assert {
    condition     = length(output.owned_properties) == 2
    error_message = "Both properties are owned now."
  }
}

run "restore_skips_the_property_owned_later" {
  command = apply

  variables {
    externalUserLifecycleAction                  = "blockSignInAndDelete"
    durationUntilExternalUserDeletedAfterBlocked = "P30D"
    restore_previous_state                       = true
    restore_over_changes                         = true
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "none" })
    error_message = "Only the property owned at the first apply is restored."
  }
}
