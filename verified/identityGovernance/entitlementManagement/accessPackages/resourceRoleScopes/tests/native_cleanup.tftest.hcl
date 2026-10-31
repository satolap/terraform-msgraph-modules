mock_provider "null" {}
mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { output = { id = "scope_before_upgrade" } }
  }
  mock_data "msgraph_resource" {
    defaults = { output = { "roles" : [{ "id" : "role-1", "displayName" : "Member", "originId" : "Member_33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup", "resource" : { "id" : "catres-00000000-0000-0000-0000-0000000000aa", "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" } }], "package" : { "id" : "77777777-7777-7777-7777-777777777777", "resourceRoleScopes" : [{ "id" : "scope_before_upgrade", "role" : { "originId" : "Member_33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }, "scope" : { "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup", "isRootScope" : true } }] } } }
  }
}
variables {
  accessPackage-id       = "77777777-7777-7777-7777-777777777777"
  catalog_id             = "11111111-1111-1111-1111-111111111111"
  catalog_resource_id    = "catres-00000000-0000-0000-0000-0000000000aa"
  resource_origin_system = "AadGroup"
  role_display_name      = "Member"
}

run "registers_verified_scope" {
  command = apply
  assert {
    condition     = length(msgraph_resource_action.remove) == 1
    error_message = "Verified creation must register cleanup."
  }
}

# An already registered remove action does not make the data-source proof one-time.
run "later_verification_change_fails_routine_plan" {
  command = plan
  override_data {
    target = data.msgraph_resource.verify_scope[0]
    values = { output = { "package" : { "id" : "77777777-7777-7777-7777-777777777777", "resourceRoleScopes" : [] } } }
  }
  expect_failures = [data.msgraph_resource.verify_scope[0]]
}

run "refuses_missing" {
  state_key = "missing"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_scope[0]
    values = { output = { "package" : { "id" : "77777777-7777-7777-7777-777777777777", "resourceRoleScopes" : [] } } }
  }
  expect_failures = [data.msgraph_resource.verify_scope[0]]
}

run "refuses_different_role" {
  state_key = "different_role"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_scope[0]
    values = { output = { "package" : { "id" : "77777777-7777-7777-7777-777777777777", "resourceRoleScopes" : [{ "id" : "scope_before_upgrade", "role" : { "originId" : "another_role", "originSystem" : "AadGroup" }, "scope" : { "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup", "isRootScope" : true } }] } } }
  }
  expect_failures = [data.msgraph_resource.verify_scope[0]]
}

run "refuses_duplicate" {
  state_key = "duplicate"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_scope[0]
    values = { output = { "package" : { "id" : "77777777-7777-7777-7777-777777777777", "resourceRoleScopes" : [{ "id" : "scope_before_upgrade", "role" : { "originId" : "Member_33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }, "scope" : { "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup", "isRootScope" : true } }, { "id" : "scope_before_upgrade", "role" : { "originId" : "Member_33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }, "scope" : { "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup", "isRootScope" : true } }] } } }
  }
  expect_failures = [data.msgraph_resource.verify_scope[0]]
}

run "refuses_incomplete" {
  state_key = "incomplete"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_scope[0]
    values = { output = { "package" : { "id" : "77777777-7777-7777-7777-777777777777", "resourceRoleScopes" : [{ "id" : "scope_before_upgrade", "role" : { "originId" : "Member_33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup" }, "scope" : { "originId" : "33333333-3333-3333-3333-333333333333", "originSystem" : "AadGroup", "isRootScope" : true } }], "resourceRoleScopes@odata.nextLink" : "more" } } }
  }
  expect_failures = [data.msgraph_resource.verify_scope[0]]
}

run "refuses_null" {
  state_key = "null"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify_scope[0]
    values = { output = { "package" : null } }
  }
  expect_failures = [data.msgraph_resource.verify_scope[0]]
}

run "refuses_unsafe_created_id" {
  state_key = "unsafe"
  command   = apply
  override_resource {
    target = msgraph_resource_action.resource_role_scope
    values = { output = { id = "../another" } }
  }
  expect_failures = [data.msgraph_resource.verify_scope[0]]
}

