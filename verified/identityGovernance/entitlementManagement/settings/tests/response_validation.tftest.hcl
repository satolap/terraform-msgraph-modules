# A malformed read must fail the plan before anything is snapshotted or written.

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
}

variables {
  externalUserLifecycleAction = "none"
}

run "rejects_a_missing_action" {
  command = plan

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { durationUntilExternalUserDeletedAfterBlocked = null } } }
  }

  expect_failures = [data.msgraph_resource.settings]
}

run "rejects_a_null_action" {
  command = plan

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { externalUserLifecycleAction = null } } }
  }

  expect_failures = [data.msgraph_resource.settings]
}

run "rejects_an_unknown_future_value_in_the_tenant" {
  command = plan

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { externalUserLifecycleAction = "unknownFutureValue" } } }
  }

  expect_failures = [data.msgraph_resource.settings]
}

run "rejects_a_non_string_duration" {
  command = plan

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { externalUserLifecycleAction = "none", durationUntilExternalUserDeletedAfterBlocked = 30 } } }
  }

  expect_failures = [data.msgraph_resource.settings]
}

run "accepts_a_missing_duration" {
  command = plan

  override_data {
    target = data.msgraph_resource.settings
    values = { output = { settings = { externalUserLifecycleAction = "blockSignIn" } } }
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ externalUserLifecycleAction = "none" })
    error_message = "A response without the duration property is valid."
  }
}
