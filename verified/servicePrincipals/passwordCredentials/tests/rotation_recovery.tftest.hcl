mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "11111111-1111-1111-1111-111111111111"
      output = {
        keyId         = "22222222-2222-2222-2222-222222222222"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [{
          keyId         = "22222222-2222-2222-2222-222222222222"
          displayName   = "Automation credential"
          startDateTime = "2026-01-01T00:00:00Z"
          endDateTime   = "2028-01-01T00:00:00Z"
        }]
      }
    }
  }
}

variables {
  acknowledge_secret_in_plan_output = true
  service_principal_id              = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
  displayName                       = "Automation credential"
}

run "creates_initial_password" {
  command = apply
  assert {
    condition     = output.keyId == "22222222-2222-2222-2222-222222222222"
    error_message = "Start with a fully registered original credential."
  }
}

run "rotation_verification_fails_after_the_new_password_is_created" {
  command = apply
  variables { rotation_trigger = "retry-generation" }
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "saved-rotation-add"
      output = {
        keyId         = "33333333-3333-3333-3333-333333333333"
        secretText    = "synthetic-password-after-rotation"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa", passwordCredentials = [] } }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "retry_registers_the_saved_key_without_resending_addpassword" {
  command = apply
  variables { rotation_trigger = "retry-generation" }
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "must-not-submit-another-add"
      output = {
        keyId         = "44444444-4444-4444-4444-444444444444"
        secretText    = "must-not-generate-another-secret"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  override_resource {
    target = msgraph_resource_action.remove
    values = { id = "registered-after-retry" }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [
          {
            keyId         = "33333333-3333-3333-3333-333333333333"
            displayName   = "Automation credential"
            startDateTime = "2026-01-01T00:00:00Z"
            endDateTime   = "2028-01-01T00:00:00Z"
          }
        ]
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.add.id == "saved-rotation-add"
    error_message = "Retry must retain the successful add action from the failed rotation, never POST again."
  }
  assert {
    condition     = output.secretText == "synthetic-password-after-rotation"
    error_message = "Retry must retain the one-time password returned by the original rotation POST."
  }
  assert {
    condition     = msgraph_resource_action.remove.body.keyId == "33333333-3333-3333-3333-333333333333"
    error_message = "Only the saved rotation keyId may be registered for cleanup on retry."
  }
  assert {
    condition     = msgraph_resource_action.remove.id == "registered-after-retry"
    error_message = "The retry must persist removal for the verified new key before deposed old cleanup can complete."
  }
}
