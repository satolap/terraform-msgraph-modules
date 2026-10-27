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
override_data {
  target = data.msgraph_resource.verify
  values = { output = { "grant" : { "id" : "owned_before_upgrade", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
}
# Seed persisted ownership corruption rather than mocking a configurable input.
run "seed_saved_id_empty" {
  state_key = "saved_id_empty"
  command   = apply
  module { source = "./tests/previous" }
  variables {
    saved_id = ""
  }
}
run "rejects_saved_id_empty" {
  state_key       = "saved_id_empty"
  command         = plan
  expect_failures = [msgraph_resource_action.remove]
}
# Seed persisted ownership corruption rather than mocking a configurable input.
run "seed_saved_id_slash" {
  state_key = "saved_id_slash"
  command   = apply
  module { source = "./tests/previous" }
  variables {
    saved_id = "../foreign"
  }
}
run "rejects_saved_id_slash" {
  state_key       = "saved_id_slash"
  command         = plan
  expect_failures = [msgraph_resource_action.remove]
}
# Seed persisted ownership corruption rather than mocking a configurable input.
run "seed_saved_id_query" {
  state_key = "saved_id_query"
  command   = apply
  module { source = "./tests/previous" }
  variables {
    saved_id = "owned?all=true"
  }
}
run "rejects_saved_id_query" {
  state_key       = "saved_id_query"
  command         = plan
  expect_failures = [msgraph_resource_action.remove]
}
# Seed persisted ownership corruption rather than mocking a configurable input.
run "seed_saved_id_fragment" {
  state_key = "saved_id_fragment"
  command   = apply
  module { source = "./tests/previous" }
  variables {
    saved_id = "owned#foreign"
  }
}
run "rejects_saved_id_fragment" {
  state_key       = "saved_id_fragment"
  command         = plan
  expect_failures = [msgraph_resource_action.remove]
}
# Seed persisted ownership corruption rather than mocking a configurable input.
run "seed_saved_id_encoded" {
  state_key = "saved_id_encoded"
  command   = apply
  module { source = "./tests/previous" }
  variables {
    saved_id = "owned%2Fforeign"
  }
}
run "rejects_saved_id_encoded" {
  state_key       = "saved_id_encoded"
  command         = plan
  expect_failures = [msgraph_resource_action.remove]
}
# Seed persisted ownership corruption rather than mocking a configurable input.
run "seed_saved_id_space" {
  state_key = "saved_id_space"
  command   = apply
  module { source = "./tests/previous" }
  variables {
    saved_id = "owned item"
  }
}
run "rejects_saved_id_space" {
  state_key       = "saved_id_space"
  command         = plan
  expect_failures = [msgraph_resource_action.remove]
}
# Seed persisted ownership corruption rather than mocking a configurable input.
run "seed_saved_id_too_long" {
  state_key = "saved_id_too_long"
  command   = apply
  module { source = "./tests/previous" }
  variables {
    saved_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
run "rejects_saved_id_too_long" {
  state_key       = "saved_id_too_long"
  command         = plan
  expect_failures = [msgraph_resource_action.remove]
}
run "seed_valid_id_minimum" {
  state_key = "valid_id_minimum"
  command   = apply
  module { source = "./tests/previous" }
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "A", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
}
run "accepts_valid_id_minimum" {
  state_key = "valid_id_minimum"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "A", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  assert {
    condition     = msgraph_resource_action.remove.resource_url == "oauth2PermissionGrants/A"
    error_message = "A verified URL-safe item ID at the length boundary must be retained exactly."
  }
}
run "seed_valid_id_maximum" {
  state_key = "valid_id_maximum"
  command   = apply
  module { source = "./tests/previous" }
  override_resource {
    target = msgraph_resource_action.grant
    values = { output = { "grant" : { "id" : "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
}
run "accepts_valid_id_maximum" {
  state_key = "valid_id_maximum"
  command   = apply
  override_data {
    target = data.msgraph_resource.verify
    values = { output = { "grant" : { "id" : "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "clientId" : "aaaaaaaa-1111-1111-1111-111111111111", "resourceId" : "bbbbbbbb-2222-2222-2222-222222222222", "consentType" : "Principal", "principalId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
  assert {
    condition     = msgraph_resource_action.remove.resource_url == "oauth2PermissionGrants/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    error_message = "A verified URL-safe item ID at the length boundary must be retained exactly."
  }
}
