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
  application-id                    = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
  displayName                       = "Automation credential"
}

run "creates_with_graph_defaults_and_registers_only_the_returned_key" {
  command = apply
  assert {
    condition     = jsonencode(msgraph_resource_action.add.body) == jsonencode({ passwordCredential = { displayName = "Automation credential" } })
    error_message = "Omit unset dates and let Graph generate the secret; never submit passwordCredentials or secretText."
  }
  assert {
    condition     = msgraph_resource_action.add.resource_url == "applications/aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "Use the application object ID in normalized Graph case."
  }
  assert {
    condition     = msgraph_resource_action.remove.when == "destroy"
    error_message = "removePassword must only execute on destroy, never when registering it."
  }
  assert {
    condition     = jsonencode(msgraph_resource_action.remove.body) == jsonencode({ keyId = "22222222-2222-2222-2222-222222222222" })
    error_message = "Cleanup must carry only the verified created keyId, never a collection or password."
  }
  assert {
    condition     = output.keyId == "22222222-2222-2222-2222-222222222222"
    error_message = "keyId comes from the creation response."
  }
  assert {
    condition     = output.secretText == "synthetic-password-for-tests-only"
    error_message = "The sensitive password output comes only from the creation response."
  }
}

run "noop_preserves_the_one_time_response" {
  command = apply
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "new-action-must-not-be-created"
      output = {
        keyId         = "22222222-2222-2222-2222-222222222222"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.add.id == "11111111-1111-1111-1111-111111111111"
    error_message = "A no-op apply must not submit a second action."
  }
}

run "application_id_case_does_not_rotate" {
  command = apply
  variables { application-id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" }
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "case-change-must-not-create"
      output = {
        keyId         = "22222222-2222-2222-2222-222222222222"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.add.id == "11111111-1111-1111-1111-111111111111"
    error_message = "A case-only application ID change must retain the action and password."
  }
}

run "explicit_rotation_replaces_both_actions" {
  command = apply
  variables { rotation_trigger = "generation-2" }
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "generation-2-add"
      output = {
        keyId         = "33333333-3333-3333-3333-333333333333"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  override_resource {
    target = msgraph_resource_action.remove
    values = {
      id = "generation-2-remove"
      output = {
        keyId         = "33333333-3333-3333-3333-333333333333"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.add.id == "generation-2-add"
    error_message = "The explicit generation token must replace the add action."
  }
  assert {
    condition     = msgraph_resource_action.remove.id == "generation-2-remove"
    error_message = "Rotation must replace the destroy-only action as well."
  }
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [{
          keyId         = "33333333-3333-3333-3333-333333333333"
          displayName   = "Automation credential"
          startDateTime = "2026-01-01T00:00:00Z"
          endDateTime   = "2028-01-01T00:00:00Z"
        }]
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.remove.body.keyId == "33333333-3333-3333-3333-333333333333"
    error_message = "Persist only this replacement's independently verified keyId for removal."
  }

}

run "changed_dates_replace_and_send_only_documented_fields" {
  command = apply
  variables {
    rotation_trigger = "generation-2"
    startDateTime    = "2026-01-01T00:00:00Z"
    endDateTime      = "2028-01-01T00:00:00Z"
  }
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "explicit-dates-add"
      output = {
        keyId         = "44444444-4444-4444-4444-444444444444"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Automation credential"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.add.id == "explicit-dates-add"
    error_message = "A date change must replace, never update an action."
  }
  assert {
    condition     = jsonencode(msgraph_resource_action.add.body.passwordCredential) == jsonencode({ displayName = "Automation credential", startDateTime = "2026-01-01T00:00:00Z", endDateTime = "2028-01-01T00:00:00Z" })
    error_message = "Send exactly the documented credential properties."
  }
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [{
          keyId         = "44444444-4444-4444-4444-444444444444"
          displayName   = "Automation credential"
          startDateTime = "2026-01-01T00:00:00Z"
          endDateTime   = "2028-01-01T00:00:00Z"
        }]
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.remove.body.keyId == "44444444-4444-4444-4444-444444444444"
    error_message = "Persist only this replacement's independently verified keyId for removal."
  }

}

run "changed_label_replaces_the_password" {
  command = apply
  variables {
    application-id   = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    displayName      = "Rotated label"
    rotation_trigger = "generation-2"
    startDateTime    = "2026-01-01T00:00:00Z"
    endDateTime      = "2028-01-01T00:00:00Z"
  }
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "changed_label_replaces_the_password"
      output = {
        keyId         = "55555555-5555-5555-5555-555555555555"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Rotated label"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
        passwordCredentials = [{
          keyId         = "55555555-5555-5555-5555-555555555555"
          displayName   = "Rotated label"
          startDateTime = "2026-01-01T00:00:00Z"
          endDateTime   = "2028-01-01T00:00:00Z"
        }]
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.add.id == "changed_label_replaces_the_password"
    error_message = "A changed creation input must replace the action instead of resubmitting it in place."
  }
  assert {
    condition     = msgraph_resource_action.remove.resource_url == "applications/aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "The new cleanup must retain the application where the new credential was created."
  }
  assert {
    condition     = msgraph_resource_action.remove.body.keyId == "55555555-5555-5555-5555-555555555555"
    error_message = "The new cleanup must retain this replacement's verified keyId."
  }
}

run "changed_parent_creates_a_credential_on_the_new_application" {
  command = apply
  variables {
    application-id   = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
    displayName      = "Rotated label"
    rotation_trigger = "generation-2"
    startDateTime    = "2026-01-01T00:00:00Z"
    endDateTime      = "2028-01-01T00:00:00Z"
  }
  override_resource {
    target = msgraph_resource_action.add
    values = {
      id = "changed_parent_creates_a_credential_on_the_new_application"
      output = {
        keyId         = "66666666-6666-6666-6666-666666666666"
        secretText    = "synthetic-password-for-tests-only"
        displayName   = "Rotated label"
        startDateTime = "2026-01-01T00:00:00Z"
        endDateTime   = "2028-01-01T00:00:00Z"
      }
    }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
        passwordCredentials = [{
          keyId         = "66666666-6666-6666-6666-666666666666"
          displayName   = "Rotated label"
          startDateTime = "2026-01-01T00:00:00Z"
          endDateTime   = "2028-01-01T00:00:00Z"
        }]
      }
    }
  }
  assert {
    condition     = msgraph_resource_action.add.id == "changed_parent_creates_a_credential_on_the_new_application"
    error_message = "A changed creation input must replace the action instead of resubmitting it in place."
  }
  assert {
    condition     = msgraph_resource_action.remove.resource_url == "applications/bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
    error_message = "The new cleanup must retain the application where the new credential was created."
  }
  assert {
    condition     = msgraph_resource_action.remove.body.keyId == "66666666-6666-6666-6666-666666666666"
    error_message = "The new cleanup must retain this replacement's verified keyId."
  }
}
