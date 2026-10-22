mock_provider "null" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "rrs-00000000-0000-0000-0000-000000000002"
      output = {
        id = "rrs-00000000-0000-0000-0000-000000000002"
      }
    }
  }

  # A subscription in the catalog, shaped like the live response of
  # GET catalogs/{id}/resources?$filter=id eq '...'&$expand=scopes: the root
  # scope plus the resource groups Graph lists under it.
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        resources = [
          {
            id           = "catres-00000000-0000-0000-0000-0000000000bb"
            displayName  = "Dev"
            originId     = "/subscriptions/88888888-8888-4888-8888-888888888888"
            originSystem = "AzureResources"
            scopes = [
              {
                id           = "scope-rg"
                displayName  = "/resourceGroups/rg-app"
                originId     = "/subscriptions/88888888-8888-4888-8888-888888888888/resourceGroups/rg-app"
                originSystem = "AzureResources"
                isRootScope  = false
              },
              {
                id           = "scope-root"
                displayName  = "Root"
                originId     = "/subscriptions/88888888-8888-4888-8888-888888888888"
                originSystem = "AzureResources"
                isRootScope  = true
              },
            ]
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
  catalog_resource_id    = "catres-00000000-0000-0000-0000-0000000000bb"
  resource_origin_system = "AzureResources"
  role_display_name      = "Reader"
  role_definition_id     = "dddddddd-dddd-4ddd-8ddd-dddddddddddd"
  role_type              = "active"
}

run "grants_active_subscription_role" {
  command = apply

  assert {
    condition     = length(data.msgraph_resource.resource_roles) == 0
    error_message = "Azure roles must not be looked up in resourceRoles, which answers 400 for AzureResources."
  }

  assert {
    condition     = data.msgraph_resource.azure_resource[0].url == "identityGovernance/entitlementManagement/catalogs/11111111-1111-1111-1111-111111111111/resources"
    error_message = "The Azure catalog resource must be read from the catalog's resources list."
  }

  assert {
    condition     = data.msgraph_resource.azure_resource[0].query_parameters["$filter"][0] == "id eq 'catres-00000000-0000-0000-0000-0000000000bb'" && data.msgraph_resource.azure_resource[0].query_parameters["$expand"][0] == "scopes"
    error_message = "The Azure catalog resource must be filtered by id with its scopes expanded."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.originId == "/subscriptions/88888888-8888-4888-8888-888888888888/providers/Microsoft.Authorization/roleDefinitions/dddddddd-dddd-4ddd-8ddd-dddddddddddd"
    error_message = "A subscription role's originId must be the role definition under the subscription."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.type == "active"
    error_message = "The role must carry its role type."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.displayName == "Reader" && msgraph_resource_action.resource_role_scope.body.role.originSystem == "AzureResources"
    error_message = "The role must carry its display name and the AzureResources origin system."
  }

  assert {
    condition = (
      msgraph_resource_action.resource_role_scope.body.role.resource.id == "catres-00000000-0000-0000-0000-0000000000bb" &&
      msgraph_resource_action.resource_role_scope.body.role.resource.originId == "/subscriptions/88888888-8888-4888-8888-888888888888" &&
      msgraph_resource_action.resource_role_scope.body.role.resource.resourceType == "Subscription"
    )
    error_message = "The role must reference the catalog resource with its origin ID and resource type."
  }

  assert {
    condition = (
      msgraph_resource_action.resource_role_scope.body.scope.id == "scope-root" &&
      msgraph_resource_action.resource_role_scope.body.scope.originId == "/subscriptions/88888888-8888-4888-8888-888888888888" &&
      msgraph_resource_action.resource_role_scope.body.scope.isRootScope == true &&
      msgraph_resource_action.resource_role_scope.body.scope.displayName == "Root"
    )
    error_message = "The default scope must be the subscription's listed root scope."
  }

  assert {
    condition     = output.role_origin_id == msgraph_resource_action.resource_role_scope.body.role.originId && output.resource_origin_id == "/subscriptions/88888888-8888-4888-8888-888888888888"
    error_message = "The outputs must expose the built role origin ID and the resource's origin ID."
  }

  assert {
    condition     = length(output.available_scopes) == 2 && output.available_roles == []
    error_message = "available_scopes must list the catalog resource's scopes, and available_roles stays empty for Azure."
  }
}

run "grants_eligible_resource_group_role" {
  command = apply

  variables {
    role_type       = "eligible"
    scope_origin_id = "/SUBSCRIPTIONS/88888888-8888-4888-8888-888888888888/resourceGroups/RG-APP"
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.type == "eligible"
    error_message = "An eligible role must be sent with type eligible."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.originId == "/subscriptions/88888888-8888-4888-8888-888888888888/providers/Microsoft.Authorization/roleDefinitions/dddddddd-dddd-4ddd-8ddd-dddddddddddd"
    error_message = "A resource group role still uses the subscription's role definition ID."
  }

  assert {
    condition = (
      msgraph_resource_action.resource_role_scope.body.scope.id == "scope-rg" &&
      msgraph_resource_action.resource_role_scope.body.scope.originId == "/subscriptions/88888888-8888-4888-8888-888888888888/resourceGroups/rg-app" &&
      msgraph_resource_action.resource_role_scope.body.scope.isRootScope == false &&
      msgraph_resource_action.resource_role_scope.body.scope.displayName == "/resourceGroups/rg-app"
    )
    error_message = "A resource group scope must be matched case-insensitively and sent as Graph lists it."
  }
}

run "grants_management_group_role" {
  command = apply

  override_data {
    target = data.msgraph_resource.azure_resource
    values = {
      output = {
        resources = [
          {
            id           = "catres-00000000-0000-0000-0000-0000000000bb"
            originId     = "/providers/Microsoft.Management/managementGroups/mg-platform"
            originSystem = "AzureResources"
            scopes = [
              {
                id           = "scope-mg-root"
                displayName  = "Root"
                originId     = "/providers/Microsoft.Management/managementGroups/mg-platform"
                originSystem = "AzureResources"
                isRootScope  = true
              },
            ]
          },
        ]
      }
    }
  }

  variables {
    role_type = "eligible"
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.originId == "/providers/Microsoft.Authorization/roleDefinitions/dddddddd-dddd-4ddd-8ddd-dddddddddddd"
    error_message = "A management group role's originId must be the tenant-wide role definition ID, as Microsoft documents."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.resource.resourceType == "ManagementGroup"
    error_message = "A management group resource must be sent with resourceType ManagementGroup."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.scope.id == "scope-mg-root" && msgraph_resource_action.resource_role_scope.body.scope.isRootScope == true
    error_message = "A management group role must use the group's root scope."
  }
}

run "sends_role_origin_id_verbatim" {
  command = apply

  variables {
    role_definition_id = null
    role_origin_id     = "/subscriptions/88888888-8888-4888-8888-888888888888/providers/Microsoft.Authorization/roleDefinitions/99999999-9999-4999-8999-999999999999"
    role_display_name  = "App Operator"
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.originId == "/subscriptions/88888888-8888-4888-8888-888888888888/providers/Microsoft.Authorization/roleDefinitions/99999999-9999-4999-8999-999999999999"
    error_message = "An explicit role_origin_id must be sent verbatim for Azure roles."
  }
}

# A custom role assignable only on a management group is not available at the
# tenant root, so its listed ID goes through role_origin_id rather than the
# tenant-wide form that role_definition_id builds.
run "sends_management_group_custom_role_verbatim" {
  command = apply

  override_data {
    target = data.msgraph_resource.azure_resource
    values = {
      output = {
        resources = [
          {
            id           = "catres-00000000-0000-0000-0000-0000000000bb"
            originId     = "/providers/Microsoft.Management/managementGroups/mg-platform"
            originSystem = "AzureResources"
            scopes = [
              {
                id           = "scope-mg-root"
                displayName  = "Root"
                originId     = "/providers/Microsoft.Management/managementGroups/mg-platform"
                originSystem = "AzureResources"
                isRootScope  = true
              },
            ]
          },
        ]
      }
    }
  }

  variables {
    role_definition_id = null
    role_origin_id     = "/providers/Microsoft.Management/managementGroups/mg-platform/providers/Microsoft.Authorization/roleDefinitions/eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee"
    role_display_name  = "Platform Operator"
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.originId == "/providers/Microsoft.Management/managementGroups/mg-platform/providers/Microsoft.Authorization/roleDefinitions/eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee"
    error_message = "A management group custom role's listed ID must be sent verbatim."
  }

  assert {
    condition     = msgraph_resource_action.resource_role_scope.body.role.resource.resourceType == "ManagementGroup" && msgraph_resource_action.resource_role_scope.body.scope.id == "scope-mg-root"
    error_message = "The management group resource and its root scope must still be resolved from the catalog."
  }
}

run "requires_role_type" {
  command = plan

  variables {
    role_type = null
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "rejects_unknown_role_type" {
  command = plan

  variables {
    role_type = "permanent"
  }

  expect_failures = [var.role_type]
}

run "rejects_role_type_outside_azure" {
  command = plan

  variables {
    resource_origin_system = "AadGroup"
    role_definition_id     = null
  }

  override_data {
    target = data.msgraph_resource.resource_roles
    values = {
      output = {
        roles = [
          { displayName = "Reader", originId = "Member_group", resource = { originId = "group" } },
        ]
      }
    }
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "rejects_role_definition_id_outside_azure" {
  command = plan

  variables {
    resource_origin_system = "AadGroup"
    role_type              = null
  }

  override_data {
    target = data.msgraph_resource.resource_roles
    values = {
      output = {
        roles = [
          { displayName = "Reader", originId = "Member_group", resource = { originId = "group" } },
        ]
      }
    }
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "requires_one_role_identifier" {
  command = plan

  variables {
    role_definition_id = null
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "rejects_both_role_identifiers" {
  command = plan

  variables {
    role_origin_id = "/providers/Microsoft.Authorization/roleDefinitions/dddddddd-dddd-4ddd-8ddd-dddddddddddd"
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "rejects_resource_id_as_role_definition_id" {
  command = plan

  variables {
    role_definition_id = "/providers/Microsoft.Authorization/roleDefinitions/dddddddd-dddd-4ddd-8ddd-dddddddddddd"
  }

  expect_failures = [var.role_definition_id]
}

run "rejects_unlisted_resource_group" {
  command = plan

  variables {
    scope_origin_id = "/subscriptions/88888888-8888-4888-8888-888888888888/resourceGroups/rg-missing"
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "rejects_missing_catalog_resource" {
  command = plan

  override_data {
    target = data.msgraph_resource.azure_resource
    values = {
      output = { resources = [] }
    }
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}

run "rejects_non_azure_catalog_resource" {
  command = plan

  override_data {
    target = data.msgraph_resource.azure_resource
    values = {
      output = {
        resources = [
          {
            id           = "catres-00000000-0000-0000-0000-0000000000bb"
            originId     = "33333333-3333-3333-3333-333333333333"
            originSystem = "AadGroup"
            scopes = [
              { id = "scope-root", originId = "33333333-3333-3333-3333-333333333333", isRootScope = true },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [msgraph_resource_action.resource_role_scope]
}
