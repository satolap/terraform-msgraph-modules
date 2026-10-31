mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        settings = {
          externalUserLifecycleAction                  = "none"
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
  externalUserLifecycleAction = "none"
}

run "accepts_each_documented_action" {
  command = plan

  variables {
    externalUserLifecycleAction = "blockSignIn"
  }

  assert {
    condition     = msgraph_update_resource.this.body.externalUserLifecycleAction == "blockSignIn"
    error_message = "blockSignIn is a documented value."
  }
}

run "rejects_unknown_future_value" {
  command = plan

  variables {
    externalUserLifecycleAction = "unknownFutureValue"
  }

  expect_failures = [var.externalUserLifecycleAction]
}

run "rejects_an_empty_action" {
  command = plan

  variables {
    externalUserLifecycleAction = ""
  }

  expect_failures = [var.externalUserLifecycleAction]
}

run "rejects_wrong_casing" {
  command = plan

  variables {
    externalUserLifecycleAction = "BlockSignIn"
  }

  expect_failures = [var.externalUserLifecycleAction]
}

run "delete_action_needs_the_acknowledgement" {
  command = plan

  variables {
    externalUserLifecycleAction = "blockSignInAndDelete"
  }

  expect_failures = [msgraph_update_resource.this]
}

run "false_acknowledgement_does_not_unlock_deletion" {
  command = plan

  variables {
    externalUserLifecycleAction  = "blockSignInAndDelete"
    allow_external_user_deletion = false
  }

  expect_failures = [msgraph_update_resource.this]
}

run "the_acknowledgement_alone_changes_nothing" {
  command = plan

  variables {
    allow_external_user_deletion = true
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "none" })
    error_message = "The acknowledgement is not a setting and must not reach the request."
  }
}

run "rejects_a_duration_without_the_delete_action" {
  command = plan

  variables {
    externalUserLifecycleAction                  = "blockSignIn"
    durationUntilExternalUserDeletedAfterBlocked = "P30D"
  }

  expect_failures = [var.durationUntilExternalUserDeletedAfterBlocked]
}

run "rejects_a_duration_that_is_not_whole_days" {
  command = plan

  variables {
    externalUserLifecycleAction                  = "blockSignInAndDelete"
    durationUntilExternalUserDeletedAfterBlocked = "PT36H"
    allow_external_user_deletion                 = true
  }

  expect_failures = [var.durationUntilExternalUserDeletedAfterBlocked]
}

run "rejects_a_leading_zero_duration" {
  command = plan

  variables {
    externalUserLifecycleAction                  = "blockSignInAndDelete"
    durationUntilExternalUserDeletedAfterBlocked = "P030D"
    allow_external_user_deletion                 = true
  }

  expect_failures = [var.durationUntilExternalUserDeletedAfterBlocked]
}

run "rejects_a_zero_duration" {
  command = plan

  variables {
    externalUserLifecycleAction                  = "blockSignInAndDelete"
    durationUntilExternalUserDeletedAfterBlocked = "P0D"
    allow_external_user_deletion                 = true
  }

  expect_failures = [var.durationUntilExternalUserDeletedAfterBlocked]
}

run "rejects_an_empty_duration" {
  command = plan

  variables {
    externalUserLifecycleAction                  = "blockSignInAndDelete"
    durationUntilExternalUserDeletedAfterBlocked = ""
    allow_external_user_deletion                 = true
  }

  expect_failures = [var.durationUntilExternalUserDeletedAfterBlocked]
}

run "restore_is_gated_by_the_snapshot_not_by_the_input" {
  command = plan

  variables {
    externalUserLifecycleAction = "blockSignInAndDelete"
    restore_previous_state      = true
  }

  # The input precondition is skipped during a restore; the snapshot precondition decides
  # instead (restore_delete_snapshot.tftest.hcl).
  assert {
    condition     = msgraph_update_resource.this.update_method == "PATCH"
    error_message = "A restore is gated by what the snapshot holds, not by the input."
  }
}

run "acknowledged_deletion_still_needs_a_duration" {
  command = plan

  variables {
    externalUserLifecycleAction  = "blockSignInAndDelete"
    allow_external_user_deletion = true
  }

  expect_failures = [msgraph_update_resource.this]
}
