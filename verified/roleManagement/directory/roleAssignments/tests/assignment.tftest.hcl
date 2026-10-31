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

run "creates_builtin_tenant_assignment" {
  command = plan
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "creates_builtin_tenant_assignment contract failed."
  }
}

run "unchanged_inputs_keep_assignment" {
  command = plan
  assert {
    condition     = output.request_body.principalId == terraform_data.preflight.input.body.principalId
    error_message = "unchanged_inputs_keep_assignment contract failed."
  }
}

run "replaces_for_principal" {
  command = plan
  variables {
    principalId = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = "22222222-2222-4222-8222-222222222222", isBuiltIn = true, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-principal", output = { assignment = {
      id               = "owned-principal"
      principalId      = "33333333-3333-4333-8333-333333333333"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"

    } } }
  }
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "replaces_for_principal contract failed."
  }
}

run "replaces_for_custom_role" {
  command = plan
  variables {
    roleDefinitionId = "11111111-1111-4111-8111-111111111111"
    role_type        = "custom"
  }
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = "11111111-1111-4111-8111-111111111111", isBuiltIn = false, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-custom_role", output = { assignment = {
      id               = "owned-custom_role"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "11111111-1111-4111-8111-111111111111"
      directoryScopeId = "/"

    } } }
  }
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "replaces_for_custom_role contract failed."
  }
}

run "replaces_for_au_scope" {
  command = plan
  variables {
    directoryScopeId = "/administrativeUnits/11111111-1111-4111-8111-111111111111"
    scope_type       = "administrative_unit"
  }
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = "22222222-2222-4222-8222-222222222222", isBuiltIn = true, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-au_scope", output = { assignment = {
      id               = "owned-au_scope"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/administrativeUnits/11111111-1111-4111-8111-111111111111"

    } } }
  }
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "replaces_for_au_scope contract failed."
  }
}

run "replaces_for_application_scope" {
  command = plan
  variables {
    directoryScopeId = "/11111111-1111-4111-8111-111111111111"
    scope_type       = "application"
  }
  override_data {
    target = data.msgraph_resource.role
    values = { output = { id = "22222222-2222-4222-8222-222222222222", isBuiltIn = true, isEnabled = true, templateId = "33333333-3333-4333-8333-333333333333" } }
  }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-application_scope", output = { assignment = {
      id               = "owned-application_scope"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/11111111-1111-4111-8111-111111111111"

    } } }
  }
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "replaces_for_application_scope contract failed."
  }
}

run "replaces_selector_even_for_same_role" {
  command = plan
  variables {
    roleDefinitionId = null
    template_id      = "33333333-3333-4333-8333-333333333333"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = null } }
  }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-template", output = { assignment = {
      id               = "owned-template"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"

    } } }
  }
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "replaces_selector_even_for_same_role contract failed."
  }
}

run "replaces_name_selector" {
  command = plan
  variables {
    roleDefinitionId  = null
    role_display_name = "Example role"
  }
  override_data {
    target = data.msgraph_resource.roles
    values = { output = { roles = [{ id = "22222222-2222-4222-8222-222222222222", templateId = "33333333-3333-4333-8333-333333333333", displayName = "Example role" }], next_link = null } }
  }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-name", output = { assignment = {
      id               = "owned-name"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"

    } } }
  }
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "replaces_name_selector contract failed."
  }
}

run "returns_to_definition_selector" {
  command = plan
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-direct", output = { assignment = {
      id               = "owned-direct"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"

    } } }
  }
  assert {
    condition     = output.request_body.directoryScopeId == terraform_data.preflight.input.body.directoryScopeId
    error_message = "returns_to_definition_selector contract failed."
  }
}

run "hex_case_baseline" {
  command = plan
  variables { principalId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-hex-case", output = { assignment = {
      id               = "owned-hex-case"
      principalId      = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"
    } } }
  }
  assert {
    condition     = output.request_body.principalId == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "The principal is normalized."
  }
}
run "guid_case_does_not_replace" {
  command = plan
  variables { principalId = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA" }
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "owned-hex-case", output = { assignment = {
      id               = "owned-hex-case"
      principalId      = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"
    } } }
  }
  assert {
    condition     = output.request_body.principalId == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "GUID case is not an assignment change."
  }
}
run "rejects_readback_principal" {
  command = plan
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "bad-principal", output = { assignment = {
      id               = "bad-principal"
      principalId      = null
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"

    } } }
  }
  expect_failures = [terraform_data.verification]
}

run "rejects_readback_role" {
  command = plan
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "bad-role", output = { assignment = {
      id               = "bad-role"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "11111111-1111-4111-8111-111111111111"
      directoryScopeId = "/"

    } } }
  }
  expect_failures = [terraform_data.verification]
}

run "rejects_readback_scope" {
  command = plan
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "bad-scope", output = { assignment = {
      id               = "bad-scope"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/11111111-1111-4111-8111-111111111111"

    } } }
  }
  expect_failures = [terraform_data.verification]
}

run "rejects_readback_namespace" {
  command = plan
  override_resource {
    override_during = plan
    target          = msgraph_resource.assignment
    values = { id = "bad-namespace", output = { assignment = {
      id               = "bad-namespace"
      principalId      = "11111111-1111-4111-8111-111111111111"
      roleDefinitionId = "22222222-2222-4222-8222-222222222222"
      directoryScopeId = "/"
      appScopeId       = "/catalog"
    } } }
  }
  expect_failures = [terraform_data.verification]
}
