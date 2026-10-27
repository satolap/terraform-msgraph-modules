mock_provider "msgraph" {}
variables {
  resourceId  = "AAAAAAAA-1111-1111-1111-111111111111"
  principalId = "BBBBBBBB-2222-2222-2222-222222222222"
  appRoleId   = "CCCCCCCC-3333-3333-3333-333333333333"
}
run "constructs_explicit_assignment" {
  command = plan
  assert {
    condition     = jsonencode(msgraph_resource_action.assignment.body) == jsonencode({ resourceId = "aaaaaaaa-1111-1111-1111-111111111111", principalId = "bbbbbbbb-2222-2222-2222-222222222222", appRoleId = "cccccccc-3333-3333-3333-333333333333" })
    error_message = "Send exactly the normalized resource, principal and app role IDs."
  }
  assert {
    condition     = msgraph_resource_action.assignment.resource_url == "servicePrincipals/aaaaaaaa-1111-1111-1111-111111111111/appRoleAssignedTo" && msgraph_resource_action.assignment.api_version == "v1.0"
    error_message = "Use the resource-side Graph-cased v1.0 path."
  }
  assert {
    condition     = length(data.msgraph_resource.resource) == 0
    error_message = "Explicit non-default IDs must not issue a lookup."
  }
}
run "explicit_default_role" {
  command = plan
  variables { appRoleId = "00000000-0000-0000-0000-000000000000" }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { output = { resource = { id = "aaaaaaaa-1111-1111-1111-111111111111", appRoles = [] } } }
  }
  assert {
    condition     = msgraph_resource_action.assignment.body.appRoleId == "00000000-0000-0000-0000-000000000000"
    error_message = "Allow the explicitly selected default role."
  }
}

run "default_role_rejects_declared_roles" {
  command = plan
  variables { appRoleId = "00000000-0000-0000-0000-000000000000" }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : [{ "id" : "cccccccc-3333-3333-3333-333333333333", "value" : "Reader", "isEnabled" : true }] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "default_role_rejects_null_roles" {
  command = plan
  variables { appRoleId = "00000000-0000-0000-0000-000000000000" }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : null } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "default_role_rejects_missing_roles" {
  command = plan
  variables { appRoleId = "00000000-0000-0000-0000-000000000000" }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111" } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "default_role_rejects_invalid_collection_type" {
  command = plan
  variables { appRoleId = "00000000-0000-0000-0000-000000000000" }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoles" : {} } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "default_role_rejects_wrong_resource" {
  command = plan
  variables { appRoleId = "00000000-0000-0000-0000-000000000000" }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "id" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoles" : [] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "default_role_rejects_missing_resource" {
  command = plan
  variables { appRoleId = "00000000-0000-0000-0000-000000000000" }
  override_data {
    target = data.msgraph_resource.resource[0]
    values = { "output" : { "resource" : { "appRoles" : [] } } }
  }
  expect_failures = [msgraph_resource_action.assignment]
}
