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

run "rejects_invalid_tenant" {
  command = plan
  variables {
    tenant_id = "bad"
  }
  expect_failures = [var.tenant_id]
}

run "rejects_invalid_principal" {
  command = plan
  variables {
    principalId = "bad"
  }
  expect_failures = [var.principalId]
}



run "rejects_invalid_role_id" {
  command = plan
  variables {
    roleDefinitionId = "bad"
  }
  expect_failures = [var.roleDefinitionId]
}

run "rejects_invalid_template" {
  command = plan
  variables {
    template_id      = "bad"
    roleDefinitionId = null
  }
  expect_failures = [var.template_id]
}

run "rejects_empty_name" {
  command = plan
  variables {
    role_display_name = "  "
    roleDefinitionId  = null
  }
  expect_failures = [var.role_display_name]
}

run "rejects_no_selector" {
  command = plan
  variables {
    roleDefinitionId = null
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_several_selectors" {
  command = plan
  variables {
    template_id = "33333333-3333-4333-8333-333333333333"
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_invalid_role_type" {
  command = plan
  variables {
    role_type = "pim"
  }
  expect_failures = [var.role_type]
}

run "rejects_custom_misclassification" {
  command = plan
  variables {
    role_type = "custom"
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_invalid_scope_type" {
  command = plan
  variables {
    scope_type = "catalog"
  }
  expect_failures = [var.scope_type]
}

run "rejects_scope_misclassification" {
  command = plan
  variables {
    directoryScopeId = "/11111111-1111-4111-8111-111111111111"
  }
  expect_failures = [terraform_data.preflight]
}

run "rejects_scope_0" {
  command = plan
  variables {
    directoryScopeId = ""
  }
  expect_failures = [var.directoryScopeId]
}

run "rejects_scope_1" {
  command = plan
  variables {
    directoryScopeId = "/applications/11111111-1111-4111-8111-111111111111"
  }
  expect_failures = [var.directoryScopeId]
}

run "rejects_scope_2" {
  command = plan
  variables {
    directoryScopeId = "/administrativeUnits/bad"
  }
  expect_failures = [var.directoryScopeId]
}

run "rejects_scope_3" {
  command = plan
  variables {
    directoryScopeId = "/administrativeunits/11111111-1111-4111-8111-111111111111"
  }
  expect_failures = [var.directoryScopeId]
}

run "rejects_scope_4" {
  command = plan
  variables {
    directoryScopeId = "/AccessPackageCatalog/11111111-1111-4111-8111-111111111111"
  }
  expect_failures = [var.directoryScopeId]
}

run "rejects_scope_5" {
  command = plan
  variables {
    directoryScopeId = "/11111111-1111-4111-8111-111111111111/"
  }
  expect_failures = [var.directoryScopeId]
}

run "rejects_scope_6" {
  command = plan
  variables {
    directoryScopeId = "/11111111-1111-4111-8111-111111111111\n"
  }
  expect_failures = [var.directoryScopeId]
}

run "rejects_scope_7" {
  command = plan
  variables {
    directoryScopeId = "//"
  }
  expect_failures = [var.directoryScopeId]
}
