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
  servicePrincipal-id               = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
  displayName                       = "Automation credential"
}

run "same_label_foreign_key_is_preserved" {
  state_key = "same_label_foreign_key_is_preserved"
  command   = apply
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
          },
          {
            keyId         = "22222222-2222-2222-2222-222222222222"
            displayName   = "Automation credential"
            startDateTime = "2026-01-01T00:00:00Z"
            endDateTime   = "2028-01-01T00:00:00Z"
          },
        ]
      }
    }
  }
  assert {
    condition     = jsonencode(msgraph_resource_action.remove.body) == jsonencode({ keyId = "22222222-2222-2222-2222-222222222222" })
    error_message = "Only the created keyId may be registered for removal, even when a foreign key has the same label and dates."
  }
}

run "rejects_missing_credentials" {
  state_key = "rejects_missing_credentials"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_null_credentials" {
  state_key = "rejects_null_credentials"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id                  = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = null
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_empty_credentials" {
  state_key = "rejects_empty_credentials"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id                  = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = []
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_foreign_parent" {
  state_key = "rejects_foreign_parent"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
        passwordCredentials = [
          {
            keyId         = "22222222-2222-2222-2222-222222222222"
            displayName   = "Automation credential"
            startDateTime = "2026-01-01T00:00:00Z"
            endDateTime   = "2028-01-01T00:00:00Z"
          }
        ]
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_foreign_key" {
  state_key = "rejects_foreign_key"
  command   = apply
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
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_duplicate_key" {
  state_key = "rejects_duplicate_key"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [
          {
            keyId         = "22222222-2222-2222-2222-222222222222"
            displayName   = "Automation credential"
            startDateTime = "2026-01-01T00:00:00Z"
            endDateTime   = "2028-01-01T00:00:00Z"
          },
          {
            keyId         = "22222222-2222-2222-2222-222222222222"
            displayName   = "Automation credential"
            startDateTime = "2026-01-01T00:00:00Z"
            endDateTime   = "2028-01-01T00:00:00Z"
          }
        ]
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_changed_label" {
  state_key = "rejects_changed_label"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [
          {
            keyId         = "22222222-2222-2222-2222-222222222222"
            displayName   = "Foreign label"
            startDateTime = "2026-01-01T00:00:00Z"
            endDateTime   = "2028-01-01T00:00:00Z"
          }
        ]
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_changed_dates" {
  state_key = "rejects_changed_dates"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [
          {
            keyId         = "22222222-2222-2222-2222-222222222222"
            displayName   = "Automation credential"
            startDateTime = "2026-01-01T00:00:00Z"
            endDateTime   = "2027-01-01T00:00:00Z"
          }
        ]
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}

run "rejects_missing_dates" {
  state_key = "rejects_missing_dates"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [
          {
            keyId       = "22222222-2222-2222-2222-222222222222"
            displayName = "Automation credential"
          }
        ]
      }
    }
  }
  expect_failures = [msgraph_resource_action.remove]
}
