mock_provider "msgraph" {}
variables {
  clientId    = "aaaaaaaa-1111-1111-1111-111111111111"
  resourceId  = "bbbbbbbb-2222-2222-2222-222222222222"
  consentType = "Principal"
  principalId = "cccccccc-3333-3333-3333-333333333333"
  scopes      = ["User.Read"]
}
run "rejects_different_id" {
  state_key = "rejects_different_id"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "foreign", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_id" {
  state_key = "rejects_missing_id"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_different_clientId" {
  state_key = "rejects_different_clientId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "foreign", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_clientId" {
  state_key = "rejects_missing_clientId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_different_resourceId" {
  state_key = "rejects_different_resourceId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "foreign", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_resourceId" {
  state_key = "rejects_missing_resourceId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_different_consentType" {
  state_key = "rejects_different_consentType"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "foreign", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_consentType" {
  state_key = "rejects_missing_consentType"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_different_principalId" {
  state_key = "rejects_different_principalId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "foreign" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_missing_principalId" {
  state_key = "rejects_missing_principalId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_null_principalId" {
  state_key = "rejects_null_principalId"
  command   = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : null } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "registers_verified_item" {
  state_key = "registers_verified_item"
  command   = apply
  variables {
  }
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
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
    condition     = msgraph_resource_action.remove.resource_url == "oauth2PermissionGrants/owned_item"
    error_message = "Removal must retain the independently verified created ID."
  }
}
run "registers_explicit_admin_consent" {
  state_key = "registers_explicit_admin_consent"
  command   = apply
  variables {
    consentType                = "AllPrincipals"
    principalId                = null
    acknowledge_all_principals = true
  }
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "AllPrincipals", "principalId" : null } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "AllPrincipals", "principalId" : null } } }
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
    condition     = msgraph_resource_action.remove.resource_url == "oauth2PermissionGrants/owned_item"
    error_message = "Removal must retain the independently verified created ID."
  }
}

run "rejects_admin_missing_principalId" {
  state_key = "rejects_admin_missing_principalId"
  variables {
    consentType                = "AllPrincipals"
    principalId                = null
    acknowledge_all_principals = true
  }
  command = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "AllPrincipals", "principalId" : null } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "AllPrincipals" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
run "rejects_admin_different_principalId" {
  state_key = "rejects_admin_different_principalId"
  variables {
    consentType                = "AllPrincipals"
    principalId                = null
    acknowledge_all_principals = true
  }
  command = apply
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "AllPrincipals", "principalId" : null } } }
  }
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_item", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "AllPrincipals", "principalId" : "foreign" } } }
  }
  expect_failures = [data.msgraph_resource.verify]
}
