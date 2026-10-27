mock_provider "msgraph" {}
variables {
  resourceId  = "aaaaaaaa-1111-1111-1111-111111111111"
  principalId = "bbbbbbbb-2222-2222-2222-222222222222"
  appRoleId   = "cccccccc-3333-3333-3333-333333333333"
}
run "rejects_different_id" {
  state_key = "rejects_different_id"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "foreign", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_id" {
  state_key = "rejects_missing_id"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_different_resourceId" {
  state_key = "rejects_different_resourceId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "foreign", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_resourceId" {
  state_key = "rejects_missing_resourceId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "owned_item", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_different_principalId" {
  state_key = "rejects_different_principalId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "foreign", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_principalId" {
  state_key = "rejects_missing_principalId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_different_appRoleId" {
  state_key = "rejects_different_appRoleId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "foreign" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_appRoleId" {
  state_key = "rejects_missing_appRoleId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "registers_verified_item" {
  state_key = "registers_verified_item"
  command   = apply
  variables {
  }
  override_resource {
    target = msgraph_resource_action.assignment
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "assignment" : { "id" : "owned_item", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  assert {
    condition     = msgraph_resource_action.remove.when == "destroy"
    error_message = "Deletion must be registered without a create/update request."
  }
  assert {
    condition     = msgraph_resource_action.remove.method == "DELETE"
    error_message = "Only exact-item DELETE is permitted."
  }
  assert {
    condition     = msgraph_resource_action.remove.resource_url == "servicePrincipals/aaaaaaaa-1111-1111-1111-111111111111/appRoleAssignedTo/owned_item"
    error_message = "Removal must retain the independently verified created ID."
  }
}
