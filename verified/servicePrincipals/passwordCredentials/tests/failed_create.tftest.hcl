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

run "rejects_missing_key_in_the_creation_response" {
  state_key = "rejects_missing_key_in_the_creation_response"
  command   = apply
  override_resource {
    target = msgraph_resource_action.add
    values = { output = { "secretText" : "synthetic-password-for-tests-only" } }
  }
  expect_failures = [msgraph_resource_action.add]
}

run "rejects_null_key_in_the_creation_response" {
  state_key = "rejects_null_key_in_the_creation_response"
  command   = apply
  override_resource {
    target = msgraph_resource_action.add
    values = { output = { "keyId" : null, "secretText" : "synthetic-password-for-tests-only" } }
  }
  expect_failures = [msgraph_resource_action.add]
}

run "rejects_missing_secret_in_the_creation_response" {
  state_key = "rejects_missing_secret_in_the_creation_response"
  command   = apply
  override_resource {
    target = msgraph_resource_action.add
    values = { output = { "keyId" : "22222222-2222-2222-2222-222222222222" } }
  }
  expect_failures = [msgraph_resource_action.add]
}

run "rejects_empty_secret_in_the_creation_response" {
  state_key = "rejects_empty_secret_in_the_creation_response"
  command   = apply
  override_resource {
    target = msgraph_resource_action.add
    values = { output = { "keyId" : "22222222-2222-2222-2222-222222222222", "secretText" : "" } }
  }
  expect_failures = [msgraph_resource_action.add]
}
