# A snapshot that holds blockSignInAndDelete may only be restored with the acknowledgement:
# the restore would turn guest deletion back on. Fresh state, separate from the other files.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "blockSignInAndDelete"
          durationUntilExternalUserDeletedAfterBlocked = "P30D"
        }
      }
    }
  }

  mock_resource "msgraph_update_resource" {
    defaults = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "blockSignIn"
          durationUntilExternalUserDeletedAfterBlocked = "P30D"
        }
      }
    }
  }
}

variables {
  externalUserLifecycleAction = "blockSignIn"
}

run "first_apply_snapshots_a_deleting_tenant" {
  command = apply

  assert {
    condition     = output.previous_state.externalUserLifecycleAction == "blockSignInAndDelete"
    error_message = "The tenant held blockSignInAndDelete before the module wrote."
  }
}

run "restore_without_acknowledgement_fails_closed" {
  command = plan

  variables {
    restore_previous_state = true
  }

  expect_failures = [msgraph_update_resource.this]
}

run "restore_with_acknowledgement_writes_the_snapshot" {
  command = apply

  variables {
    restore_previous_state       = true
    allow_external_user_deletion = true
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "blockSignInAndDelete" })
    error_message = "With the acknowledgement the restore writes the snapshot value."
  }
}
