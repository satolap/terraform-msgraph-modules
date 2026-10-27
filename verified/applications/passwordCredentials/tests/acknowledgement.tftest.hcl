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
  application_id = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
  displayName    = "Automation credential"
}

run "rejects_use_without_explicit_acknowledgement" {
  command         = plan
  expect_failures = [var.acknowledge_secret_in_plan_output]
}

run "rejects_false_acknowledgement" {
  command = plan
  variables { acknowledge_secret_in_plan_output = false }
  expect_failures = [var.acknowledge_secret_in_plan_output]
}

run "acknowledgement_does_not_mark_the_resource_secret_sensitive" {
  command = apply
  variables { acknowledge_secret_in_plan_output = true }
  assert {
    condition     = !issensitive(msgraph_resource_action.add.output.secretText)
    error_message = "The provider response remains nonsensitive; the acknowledgement must not imply redaction."
  }
  assert {
    condition     = issensitive(output.secretText)
    error_message = "Keep the separate module output marked sensitive despite the resource-level limitation."
  }
}
