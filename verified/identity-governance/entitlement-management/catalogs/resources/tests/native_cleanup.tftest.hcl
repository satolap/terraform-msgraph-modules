mock_provider "null" {}
mock_provider "time" {}
mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { output = { request_id = "saved_request", state = "delivered" } }
  }
  mock_data "msgraph_resource" {
    defaults = { output = { resources = [{ id = "resource_before_upgrade", originId = "33333333-3333-3333-3333-333333333333", originSystem = "AadGroup" }] } }
  }
}
variables {
  catalog_id                 = "11111111-1111-1111-1111-111111111111"
  resource_origin_id         = "33333333-3333-3333-3333-333333333333"
  resource_origin_system     = "AadGroup"
  verification_delay_seconds = 0
}

run "registers_verified_resource" {
  command = apply
  assert {
    condition     = length(msgraph_resource_action.remove) == 1
    error_message = "Verified creation must register removal."
  }
}

# An already registered remove action does not make the data-source proof one-time.
run "later_verification_change_fails_routine_plan" {
  command = plan
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : [] } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_missing" {
  state_key = "missing"
  command   = apply
  variables { fail_on_verification_mismatch = false }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : [] } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_different_origin" {
  state_key = "different_origin"
  command   = apply
  variables { fail_on_verification_mismatch = false }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : [{ "id" : "resource_before_upgrade", "originId" : "different", "originSystem" : "AadGroup" }] } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_different_system" {
  state_key = "different_system"
  command   = apply
  variables { fail_on_verification_mismatch = false }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : [{ "id" : "resource_before_upgrade", "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadApplication" }] } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_duplicate" {
  state_key = "duplicate"
  command   = apply
  variables { fail_on_verification_mismatch = false }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : [{ "id" : "resource_before_upgrade", "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }, { "id" : "resource_before_upgrade", "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }] } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_incomplete" {
  state_key = "incomplete"
  command   = apply
  variables { fail_on_verification_mismatch = false }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : [{ "id" : "resource_before_upgrade", "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }], "next_link" : "more" } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_null" {
  state_key = "null"
  command   = apply
  variables { fail_on_verification_mismatch = false }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : null } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "refuses_unsafe_id" {
  state_key = "unsafe_id"
  command   = apply
  variables { fail_on_verification_mismatch = false }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "resources" : [{ "id" : "../another", "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }] } }
  }
  expect_failures = [data.msgraph_resource.verify]
}

run "removal_retry_is_bounded_and_destroy_only" {
  command = plan
  assert {
    condition     = msgraph_resource_action.remove[0].timeouts.delete == "2m" && msgraph_resource_action.remove[0].when == "destroy"
    error_message = "Retry must be bounded on destroy and never run adminRemove during registration."
  }
}

run "directory_role_registers_verified_counter_request" {
  state_key = "directory_role"
  command   = apply
  variables {
    resource_origin_system             = "DirectoryRole"
    acknowledge_directory_role_preview = true
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { resources = [{ id = "directory_role_resource", originId = "33333333-3333-3333-3333-333333333333", originSystem = "DirectoryRole" }] } }
  }
  assert {
    condition     = output.verified && output.resource_id == "directory_role_resource"
    error_message = "Catalog onboarding must independently verify the DirectoryRole resource."
  }
  assert {
    condition = msgraph_resource_action.remove[0].body == {
      requestType = "adminRemove"
      catalog     = { id = "11111111-1111-1111-1111-111111111111" }
      resource    = { id = "directory_role_resource" }
    }
    error_message = "Removal must name only the saved catalog resource ID, never the role definition."
  }
}

run "directory_role_unchanged_plan_preserves_request" {
  state_key = "directory_role"
  command   = plan
  variables {
    resource_origin_system             = "DirectoryRole"
    acknowledge_directory_role_preview = true
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { resources = [{ id = "directory_role_resource", originId = "33333333-3333-3333-3333-333333333333", originSystem = "DirectoryRole" }] } }
  }
  assert {
    condition     = output.request_id == run.directory_role_registers_verified_counter_request.request_id && output.resource_id == run.directory_role_registers_verified_counter_request.resource_id
    error_message = "An unchanged plan must retain the request and verified resource identities."
  }
}
