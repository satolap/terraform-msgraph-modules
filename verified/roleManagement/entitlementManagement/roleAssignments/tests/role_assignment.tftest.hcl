mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id     = "aaaaaaaa-0000-0000-0000-000000000001"
      output = {}
    }
  }
}

variables {
  principalId = "11111111-1111-4111-8111-111111111111"
  catalog_id  = "22222222-2222-4222-8222-222222222222"
}

run "catalog_owner_uses_the_catalog_app_scope" {
  command = apply

  variables {
    role = "catalog_owner"
  }

  assert {
    condition     = msgraph_resource.assignment.url == "roleManagement/entitlementManagement/roleAssignments" && msgraph_resource.assignment.api_version == "v1.0"
    error_message = "The assignment must be created in roleManagement/entitlementManagement/roleAssignments on v1.0."
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment.body) == jsonencode({
      appScopeId       = "/AccessPackageCatalog/22222222-2222-4222-8222-222222222222"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "ae79f266-94d4-4dab-b730-feca7e132178"
    })
    error_message = "A catalog role must send principalId, the role definition ID and appScopeId, and no directoryScopeId."
  }

  assert {
    condition     = output.id == "aaaaaaaa-0000-0000-0000-000000000001" && output.role_definition_id == "ae79f266-94d4-4dab-b730-feca7e132178" && output.principal_id == "11111111-1111-4111-8111-111111111111"
    error_message = "The id must come from the resource, the other outputs from the inputs."
  }

  assert {
    condition     = output.app_scope_id == "/AccessPackageCatalog/22222222-2222-4222-8222-222222222222" && output.directory_scope_id == null
    error_message = "A catalog role must output app_scope_id and a null directory_scope_id."
  }
}

run "catalog_reader_role_definition_id" {
  command = plan

  variables {
    role = "catalog_reader"
  }

  assert {
    condition     = msgraph_resource.assignment.body.roleDefinitionId == "44272f93-9762-48e8-af59-1b5351b1d6b3" && msgraph_resource.assignment.body.appScopeId == "/AccessPackageCatalog/22222222-2222-4222-8222-222222222222" && !contains(keys(msgraph_resource.assignment.body), "directoryScopeId")
    error_message = "catalog_reader must send its documented role definition ID with the catalog app scope."
  }
}

run "access_package_manager_role_definition_id" {
  command = plan

  variables {
    role = "access_package_manager"
  }

  assert {
    condition     = msgraph_resource.assignment.body.roleDefinitionId == "7f480852-ebdc-47d4-87de-0d8498384a83" && msgraph_resource.assignment.body.appScopeId == "/AccessPackageCatalog/22222222-2222-4222-8222-222222222222" && !contains(keys(msgraph_resource.assignment.body), "directoryScopeId")
    error_message = "access_package_manager must send its documented role definition ID with the catalog app scope."
  }
}

run "access_package_assignment_manager_role_definition_id" {
  command = plan

  variables {
    role = "access_package_assignment_manager"
  }

  assert {
    condition     = msgraph_resource.assignment.body.roleDefinitionId == "e2182095-804a-4656-ae11-64734e9b7ae5" && msgraph_resource.assignment.body.appScopeId == "/AccessPackageCatalog/22222222-2222-4222-8222-222222222222" && !contains(keys(msgraph_resource.assignment.body), "directoryScopeId")
    error_message = "access_package_assignment_manager must send its documented role definition ID with the catalog app scope."
  }
}

run "catalog_creator_is_tenant_wide" {
  command = apply

  variables {
    role       = "catalog_creator"
    catalog_id = null
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment.body) == jsonencode({
      directoryScopeId = "/"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "ba92d953-d8e0-4e39-a797-0cbedb0a89e8"
    })
    error_message = "catalog_creator must send directoryScopeId \"/\" and no appScopeId."
  }

  assert {
    condition     = output.app_scope_id == null && output.directory_scope_id == "/" && output.role_definition_id == "ba92d953-d8e0-4e39-a797-0cbedb0a89e8"
    error_message = "A tenant-wide role must output directory_scope_id and a null app_scope_id."
  }
}

run "raw_role_definition_with_catalog_is_catalog_scoped" {
  command = plan

  variables {
    roleDefinitionId = "11111111-2222-3333-4444-555555555555"
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment.body) == jsonencode({
      appScopeId       = "/AccessPackageCatalog/22222222-2222-4222-8222-222222222222"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "11111111-2222-3333-4444-555555555555"
    })
    error_message = "A raw role definition ID with catalog_id must be scoped to the catalog."
  }
}

run "raw_role_definition_without_catalog_is_tenant_wide" {
  command = plan

  variables {
    roleDefinitionId = "11111111-2222-3333-4444-555555555555"
    catalog_id       = null
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment.body) == jsonencode({
      directoryScopeId = "/"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "11111111-2222-3333-4444-555555555555"
    })
    error_message = "A raw role definition ID without catalog_id must be tenant-wide."
  }
}

run "beta_api_version_is_passed_on" {
  command = plan

  variables {
    role        = "catalog_reader"
    api_version = "beta"
  }

  assert {
    condition     = msgraph_resource.assignment.api_version == "beta"
    error_message = "api_version must reach the resource."
  }
}

run "a_changed_input_replaces_the_assignment_without_create_before_destroy" {
  command = plan

  variables {
    role        = "catalog_owner"
    principalId = "33333333-3333-4333-8333-333333333333"
  }

  assert {
    condition     = terraform_data.immutable.input.principal_id == "33333333-3333-4333-8333-333333333333" && terraform_data.immutable.input.app_scope_id == "/AccessPackageCatalog/22222222-2222-4222-8222-222222222222"
    error_message = "The replace trigger must carry the principal and the scope."
  }
}

run "refuses_neither_role_nor_definition" {
  command = plan

  expect_failures = [msgraph_resource.assignment]
}

run "refuses_both_role_and_definition" {
  command = plan

  variables {
    role             = "catalog_owner"
    roleDefinitionId = "11111111-2222-3333-4444-555555555555"
  }

  expect_failures = [msgraph_resource.assignment]
}

run "refuses_catalog_role_without_catalog" {
  command = plan

  variables {
    role       = "catalog_owner"
    catalog_id = null
  }

  expect_failures = [msgraph_resource.assignment]
}

run "refuses_catalog_creator_with_catalog" {
  command = plan

  variables {
    role = "catalog_creator"
  }

  expect_failures = [msgraph_resource.assignment]
}

run "refuses_unknown_role" {
  command = plan

  variables {
    role = "connected_organization_administrator"
  }

  expect_failures = [var.role]
}

run "refuses_malformed_principal" {
  command = plan

  variables {
    role        = "catalog_owner"
    principalId = "not-a-guid"
  }

  expect_failures = [var.principalId]
}

run "refuses_malformed_role_definition" {
  command = plan

  variables {
    roleDefinitionId = "e65cf63f-9cc2-4b48-8871-cb667e9d90f"
    catalog_id       = null
  }

  expect_failures = [var.roleDefinitionId]
}

run "refuses_malformed_catalog" {
  command = plan

  variables {
    role       = "catalog_owner"
    catalog_id = "not-a-guid"
  }

  expect_failures = [var.catalog_id]
}

run "refuses_unknown_api_version" {
  command = plan

  variables {
    role        = "catalog_owner"
    api_version = "v2"
  }

  expect_failures = [var.api_version]
}

run "guid_inputs_are_sent_in_lower_case" {
  command = apply

  variables {
    principalId      = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
    catalog_id       = "BBBBBBBB-BBBB-4BBB-8BBB-BBBBBBBBBBBB"
    role             = null
    roleDefinitionId = "CCCCCCCC-CCCC-4CCC-8CCC-CCCCCCCCCCCC"
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment.body) == jsonencode({
      appScopeId       = "/AccessPackageCatalog/bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
      principalId      = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      roleDefinitionId = "cccccccc-cccc-4ccc-8ccc-cccccccccccc"
    })
    error_message = "GUID inputs must be sent in lower case, the form Graph answers with, so they do not show as drift."
  }

  assert {
    condition     = terraform_data.immutable.input.principal_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && terraform_data.immutable.input.role_definition_id == "cccccccc-cccc-4ccc-8ccc-cccccccccccc" && terraform_data.immutable.input.app_scope_id == "/AccessPackageCatalog/bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
    error_message = "The replacement trigger must hold the lower-case values."
  }

  assert {
    condition     = output.principal_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" && output.role_definition_id == "cccccccc-cccc-4ccc-8ccc-cccccccccccc"
    error_message = "The outputs must carry the lower-case values."
  }
}
