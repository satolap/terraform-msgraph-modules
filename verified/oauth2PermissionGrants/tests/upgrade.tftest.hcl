mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { id = "saved-post-action", output = { "grant" : { "id" : "owned_before_upgrade", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
}
variables {
  clientId    = "aaaaaaaa-1111-1111-1111-111111111111"
  resourceId  = "bbbbbbbb-2222-2222-2222-222222222222"
  consentType = "Principal"
  principalId = "cccccccc-3333-3333-3333-333333333333"
  scopes      = ["User.Read"]
}
# The fixture has the legacy immutable/POST/owned state shape and no remove action.
run "legacy_state_without_remove" {
  state_key = "upgrade"
  command   = apply
  module { source = "./tests/previous" }
  assert {
    condition     = terraform_data.owned.input.grantId == "owned_before_upgrade"
    error_message = "The legacy owned record must contain the old created item ID."
  }
}
run "unchanged_apply_registers_old_url" {
  state_key = "upgrade"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "owned_before_upgrade", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  assert {
    condition     = terraform_data.owned.id == run.legacy_state_without_remove.owned_state_id
    error_message = "An unchanged upgrade must retain the legacy ownership record without replacement."
  }
  assert {
    condition     = msgraph_resource_action.grant.id == "saved-post-action"
    error_message = "Upgrade must retain the existing POST action."
  }
  assert {
    condition     = msgraph_resource_action.remove.resource_url == "oauth2PermissionGrants/owned_before_upgrade"
    error_message = "Upgrade must register deletion of the existing saved URL."
  }
  assert {
    condition     = msgraph_resource_action.remove.when == "destroy"
    error_message = "Upgrade only registers deletion; it must not DELETE during apply."
  }
}
