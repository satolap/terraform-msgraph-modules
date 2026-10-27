mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = { "id" : "owned_assignment_1", "output" : { "assignment" : { "id" : "owned_assignment_1", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
  }
}
# Fixed response identities for offline assertions.
override_resource {
  target = msgraph_resource_action.assignment
  values = { "id" : "owned_assignment_1", "output" : { "assignment" : { "id" : "owned_assignment_1", "resourceId" : "aaaaaaaa-1111-1111-1111-111111111111", "principalId" : "bbbbbbbb-2222-2222-2222-222222222222", "appRoleId" : "cccccccc-3333-3333-3333-333333333333" } } }
}

variables {
  resourceId  = "AAAAAAAA-1111-1111-1111-111111111111"
  principalId = "BBBBBBBB-2222-2222-2222-222222222222"
  appRoleId   = "CCCCCCCC-3333-3333-3333-333333333333"
}

run "neither_selector" {
  command = plan
  variables {
    appRoleId = null
  }
  expect_failures = [msgraph_resource_action.assignment]
}

run "empty_role" {
  command = plan
  variables {
    appRoleId = ""
  }
  expect_failures = [var.appRoleId]
}

run "invalid_role" {
  command = plan
  variables {
    appRoleId = "invalid"
  }
  expect_failures = [var.appRoleId]
}

run "invalid_resource" {
  command = plan
  variables {
    resourceId = "invalid"
  }
  expect_failures = [var.resourceId]
}

run "invalid_principal" {
  command = plan
  variables {
    principalId = "invalid"
  }
  expect_failures = [var.principalId]
}

run "empty_value" {
  command = plan
  variables {
    appRoleId    = null
    appRoleValue = " "
  }
  expect_failures = [var.appRoleValue]
}

run "null_optional_value" {
  command = plan
  variables {
    appRoleValue = null
  }
  assert {
    condition     = length(data.msgraph_resource.resource) == 0
    error_message = "Explicit appRoleId must not issue a lookup."
  }
}
