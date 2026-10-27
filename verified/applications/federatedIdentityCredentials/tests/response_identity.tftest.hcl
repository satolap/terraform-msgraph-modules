mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = { id = "11111111-1111-1111-1111-111111111111" }
  }
}

variables {
  application_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
  name           = "github-main"
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:example-org/example-repo:ref:refs/heads/main"
}

run "rejects_missing_id" {
  command = apply
  variables { name = "missing-id" }
  override_resource {
    target = msgraph_resource.credential
    values = { output = { name = "missing-id" } }
  }
  expect_failures = [msgraph_resource.credential]
}

run "rejects_null_id" {
  command = apply
  variables { name = "null-id" }
  override_resource {
    target = msgraph_resource.credential
    values = { output = { id = null, name = "null-id" } }
  }
  expect_failures = [msgraph_resource.credential]
}

run "rejects_different_id" {
  command = apply
  variables { name = "different-id" }
  override_resource {
    target = msgraph_resource.credential
    values = { output = { id = "22222222-2222-2222-2222-222222222222", name = "different-id" } }
  }
  expect_failures = [msgraph_resource.credential]
}

run "rejects_missing_name" {
  command = apply
  variables { name = "missing-name" }
  override_resource {
    target = msgraph_resource.credential
    values = { output = { id = "11111111-1111-1111-1111-111111111111" } }
  }
  expect_failures = [msgraph_resource.credential]
}

run "rejects_null_name" {
  command = apply
  variables { name = "null-name" }
  override_resource {
    target = msgraph_resource.credential
    values = { output = { id = "11111111-1111-1111-1111-111111111111", name = null } }
  }
  expect_failures = [msgraph_resource.credential]
}

run "rejects_different_name" {
  command = apply
  variables { name = "different-name" }
  override_resource {
    target = msgraph_resource.credential
    values = { output = { id = "11111111-1111-1111-1111-111111111111", name = "different" } }
  }
  expect_failures = [msgraph_resource.credential]
}

run "rejects_wrapped_identity" {
  command = apply
  variables { name = "wrapped-identity" }
  override_resource {
    target = msgraph_resource.credential
    values = { output = { value = { id = "11111111-1111-1111-1111-111111111111", name = "wrapped-identity" } } }
  }
  expect_failures = [msgraph_resource.credential]
}

run "accepts_returned_id_with_different_hex_case" {
  command = apply
  variables { name = "case-test" }
  override_resource {
    target = msgraph_resource.credential
    values = {
      id     = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      output = { id = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA", name = "case-test" }
    }
  }
  assert {
    condition     = output.id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "The returned GUID is the same identity regardless of hex case."
  }
}

run "rejects_non_guid_stored_identity" {
  command = apply
  variables { name = "invalid-guid" }
  override_resource {
    target = msgraph_resource.credential
    values = {
      id     = "not-a-credential-guid"
      output = { id = "not-a-credential-guid", name = "invalid-guid" }
    }
  }
  expect_failures = [msgraph_resource.credential]
}
