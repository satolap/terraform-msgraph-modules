mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { "id" : "owned_assignment_1", "output" : { "assignment" : { "id" : "owned_assignment_1", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
}
# Fixed response identities for offline assertions.
override_resource {
  target = msgraph_resource_action.assignment
  values = { "id" : "owned_assignment_1", "output" : { "assignment" : { "id" : "owned_assignment_1", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
}

variables {
  resourceId   = "AAAAAAAA-1111-1111-1111-111111111111"
  principalId  = "BBBBBBBB-2222-2222-2222-222222222222"
  appRoleValue = "Reader"
}

run "lookup_exact_value_read_only" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : true }, { "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Other", "isEnabled" : true }] } } }
  }
  assert {
    condition     = msgraph_resource_action.assignment.body.appRoleId == "cccccccc-3333-3333-3333-333333333333"
    error_message = "Resolve exactly one enabled app role by value."
  }
  assert {
    condition     = data.msgraph_resource.resource[0].query_parameters["$select"][0] == "id,appRoles"
    error_message = "Read only the resource identity and role definitions."
  }
}

run "rejects_zero_matches" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_case_mismatch" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_duplicate_matches" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : true }, { "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_disabled_role" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : false }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_duplicate_one_disabled" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : true }, { "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : false }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_malformed_role_id" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "invalid", "value" : "Reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_missing_role_id" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "value" : "Reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_null_role_id" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : null, "value" : "Reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_wrong_resource" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "dddddddd-4444-4444-4444-444444444444", "appRoles" : [{ "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_null_collection" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : null } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "rejects_both_selectors" {
  command = plan
  variables {
    appRoleId = "CCCCCCCC-3333-3333-3333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "CCCCCCCC-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "lookup_cannot_bypass_default_role_guard" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { output = { resource = {
      id       = "aaaaaaaa-1111-1111-1111-111111111111"
      appRoles = [{ id = "00000000-0000-0000-0000-000000000000", value = "Reader", isEnabled = true }]
    } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}
