# Plan-only mocks never execute provisioners. Python tests exercise the guards
# and stateful replacement ordering with inert CLI and HTTP transports.
mock_provider "msgraph" {
  override_during = plan
  mock_resource "msgraph_resource" {
    defaults = {
      id = "owned-assignment-1"
      output = { assignment = {
        id               = "owned-assignment-1"
        principalId      = "11111111-1111-4111-8111-111111111111"
        roleDefinitionId = "22222222-2222-4222-8222-222222222222"
        directoryScopeId = "/"
      } }
    }
  }
}
override_data {
  target = data.msgraph_resource.role
  values = { output = { id = "22222222-2222-4222-8222-222222222222", isBuiltIn = true, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
}
override_data {
  target = data.msgraph_resource.roles
  values = { output = { roles = [], next_link = null } }
}
variables {
  tenant_id        = "99999999-9999-4999-8999-999999999999"
  scope_type       = "tenant"
  directoryScopeId = "/"
  principalId      = "11111111-1111-4111-8111-111111111111"
  roleDefinitionId = "22222222-2222-4222-8222-222222222222"
}

run "resolves_template" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = null } }
  }
  assert {
    condition     = output.role_definition_id == "22222222-2222-4222-8222-222222222222"
    error_message = "resolves_template contract failed."
  }
}

run "resolves_exact_name" {
  command = plan
  variables {
    roleDefinitionId  = null
    role_display_name = "Example role"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = null } }
  }
  assert {
    condition     = output.role_definition_id == "22222222-2222-4222-8222-222222222222"
    error_message = "resolves_exact_name contract failed."
  }
}

run "escapes_odata_quotes" {
  command = plan
  variables {
    roleDefinitionId  = null
    role_display_name = "Example's role"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example's role" }], next_link = null } }
  }
  assert {
    condition     = data.msgraph_resource.roles[0].query_parameters["$filter"][0] == "displayName eq 'Example''s role'"
    error_message = "escapes_odata_quotes contract failed."
  }
}

run "rejects_template_zero" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [], next_link = null } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_template_ambiguous" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }, { id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = null } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_template_unrelated" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "11111111-1111-4111-8111-111111111111", displayName = "Other" }], next_link = null } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_template_incomplete" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions?$skiptoken=more" } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_name_zero" {
  command = plan
  variables {
    roleDefinitionId  = null
    role_display_name = "Example role"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [], next_link = null } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_name_ambiguous" {
  command = plan
  variables {
    roleDefinitionId  = null
    role_display_name = "Example role"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }, { id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = null } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_name_unrelated" {
  command = plan
  variables {
    roleDefinitionId  = null
    role_display_name = "Example role"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "11111111-1111-4111-8111-111111111111", displayName = "Other" }], next_link = null } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_name_incomplete" {
  command = plan
  variables {
    roleDefinitionId  = null
    role_display_name = "Example role"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions?$skiptoken=more" } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_role_disabled" {
  command = plan
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = "22222222-2222-4222-8222-222222222222", isBuiltIn = true, isEnabled = false, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_role_missing_identity" {
  command = plan
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = null, isBuiltIn = true, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_role_wrong_identity" {
  command = plan
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = "11111111-1111-4111-8111-111111111111", isBuiltIn = true, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_role_null_builtin" {
  command = plan
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = "22222222-2222-4222-8222-222222222222", isBuiltIn = null, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_template_null_collection" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = null } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_template_missing_collection" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [] } }
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_template_invalid_identifier_collection" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "../roleAssignments", templateId = "33333333-3333-4333-8333-333333333333" }] } }
  }
  expect_failures = [terraform_data.preflight]
}
