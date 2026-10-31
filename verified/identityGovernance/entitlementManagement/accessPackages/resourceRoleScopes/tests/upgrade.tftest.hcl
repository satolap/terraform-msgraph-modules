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

# The real null provider preserves and compares legacy trigger state. No legacy
# provisioner can execute in this fixture; its state shape is otherwise intact.
run "legacy_state_without_remove" {
  state_key = "upgrade"
  command   = apply
  module { source = "./tests/previous" }
  # The previous release declares the inputs under their former names.
  variables {
    access_package_id = "77777777-7777-7777-7777-777777777777"
  }
}
run "unchanged_apply_registers_old_url" {
  state_key = "upgrade"
  command   = apply
  assert {
    condition     = null_resource.remove_on_destroy[0].id == run.legacy_state_without_remove.owned_state_id
    error_message = "An unchanged upgrade must preserve the legacy trigger resource."
  }
  assert {
    condition     = msgraph_resource_action.resource_role_scope.id == run.legacy_state_without_remove.post_state_id
    error_message = "Upgrade must retain the original POST without replacement."
  }
  assert {
    condition     = msgraph_resource_action.remove[0].resource_url == "identityGovernance/entitlementManagement/accessPackages/77777777-7777-7777-7777-777777777777/resourceRoleScopes/scope_before_upgrade"
    error_message = "Registration must retain the exact old URL."
  }
  assert {
    condition     = msgraph_resource_action.remove[0].when == "destroy" && msgraph_resource_action.remove[0].method == "DELETE"
    error_message = "Registration must send no request during apply."
  }
}
