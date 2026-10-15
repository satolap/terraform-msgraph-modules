mock_provider "null" {}

mock_provider "msgraph" {
  # The role scope is created via a one-shot msgraph_resource_action (the
  # entity has no GET-by-id endpoint — see main.tf). The mocked create
  # response exports an ID; enable_destroy_cleanup=false isolates teardown.
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "rrs-00000000-0000-0000-0000-000000000001"
      output = {
        id = "rrs-00000000-0000-0000-0000-000000000001"
      }
    }
  }

  # The catalog reports a Member and an Owner role for the group resource,
  # mirroring what GET catalogs/{id}/resourceRoles returns with $expand=resource.
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        roles = [
          {
            id           = "role-1"
            displayName  = "Member"
            originId     = "Member_33333333-3333-3333-3333-333333333333"
            originSystem = "AadGroup"
            resource = {
              id           = "catres-00000000-0000-0000-0000-0000000000aa"
              originId     = "33333333-3333-3333-3333-333333333333"
              originSystem = "AadGroup"
            }
          },
          {
            id           = "role-2"
            displayName  = "Owner"
            originId     = "Owner_33333333-3333-3333-3333-333333333333"
            originSystem = "AadGroup"
            resource = {
              id           = "catres-00000000-0000-0000-0000-0000000000aa"
              originId     = "33333333-3333-3333-3333-333333333333"
              originSystem = "AadGroup"
            }
          },
        ]
      }
    }
  }
}

variables {
  enable_destroy_cleanup = false
  access_package_id      = "77777777-7777-7777-7777-777777777777"
  catalog_id             = "11111111-1111-1111-1111-111111111111"
  catalog_resource_id    = "catres-00000000-0000-0000-0000-0000000000aa"
  resource_origin_system = "AadGroup"
  role_display_name      = "member" # lowercase on purpose: matching is case-insensitive
}

run "grants_member_role" {
  command = apply

  assert {
    condition     = msgraph_resource_action.resource_role_scope.resource_url == "identityGovernance/entitlementManagement/accessPackages/77777777-7777-7777-7777-777777777777/resourceRoleScopes"
    error_message = "Role scope must be created on the access package's resourceRoleScopes endpoint."
  }

  assert {
    condition     = data.msgraph_resource.resource_roles.url == "identityGovernance/entitlementManagement/catalogs/11111111-1111-1111-1111-111111111111/resourceRoles"
    error_message = "Roles must be resolved from the catalog's resourceRoles endpoint."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.method == "POST"
    error_message = "The role scope must be created with a one-shot POST action (the entity has no GET-by-id endpoint)."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.originId == "Member_33333333-3333-3333-3333-333333333333"
    error_message = "The role originId must be resolved from the catalog's resourceRoles list, matched case-insensitively by display name."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.resource.id == "catres-00000000-0000-0000-0000-0000000000aa"
    error_message = "The role must reference the catalog-internal accessPackageResource id."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.scope.originId == "33333333-3333-3333-3333-333333333333"
    error_message = "The default scope must be the resource's own origin id (root scope)."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.scope.isRootScope == true
    error_message = "The default scope must be marked as the root scope."
  }

  assert {
    condition     = output.role_origin_id == "Member_33333333-3333-3333-3333-333333333333"
    error_message = "role_origin_id output must expose the resolved origin id."
  }

  assert {
    condition     = output.resource_origin_id == "33333333-3333-3333-3333-333333333333"
    error_message = "resource_origin_id output must expose the resource's origin id from the lookup."
  }
}

run "matches_by_origin_id_override" {
  command = apply

  variables {
    role_display_name = "Owner"
    role_origin_id    = "Owner_33333333-3333-3333-3333-333333333333"
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.originId == "Owner_33333333-3333-3333-3333-333333333333"
    error_message = "An explicit role_origin_id must be matched against the roles list and used verbatim."
  }
}

run "supports_custom_sub_scope" {
  command = apply

  variables {
    scope_origin_id    = "https://contoso.sharepoint.com/sites/eng/Lists/Docs"
    scope_display_name = "Docs list"
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.scope.originId == "https://contoso.sharepoint.com/sites/eng/Lists/Docs"
    error_message = "A custom scope_origin_id must be passed through."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.scope.isRootScope == false
    error_message = "A custom scope must not be marked as root scope."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.scope.displayName == "Docs list"
    error_message = "A custom scope display name must be passed through."
  }
}

run "fails_when_role_not_found" {
  command = plan

  variables {
    role_display_name = "Visitor"
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "rejects_invalid_origin_system" {
  command = plan

  variables {
    resource_origin_system = "AzureResource"
  }

  expect_failures = [var.resource_origin_system]
}

run "rejects_empty_role_display_name" {
  command = plan

  variables {
    role_display_name = ""
  }

  expect_failures = [var.role_display_name]
}

run "rejects_ambiguous_role_display_name" {
  command = plan
  override_data {
    target = data.msgraph_resource.resource_roles
    values = {
      output = {
        roles = [
          { displayName = "Member", originId = "role-a", resource = { originId = "group-a" } },
          { displayName = "member", originId = "role-b", resource = { originId = "group-a" } },
        ]
      }
    }
  }
  expect_failures = [msgraph_resource_action.resource_role_scope]
}
