# v4.0.0 spelled the identity_sources attributes in snake_case. Terraform drops an unknown
# object attribute silently, so the guard rejects an old name that carries a value.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "22222222-2222-2222-2222-222222222222"
    }
  }

  mock_resource "msgraph_resource_collection" {
    defaults = {
      id = "identityGovernance/entitlementManagement/connectedOrganizations/22222222-2222-2222-2222-222222222222/sponsors"
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        organizations = []
        tenant_id     = "44444444-4444-4444-4444-444444444444"
        display_name  = "Fabrikam"
      }
    }
  }
}

variables {
  displayName = "Fabrikam"
}

run "the_graph_names_are_accepted" {
  command = plan
  variables {
    identity_sources = [
      { type = "tenant", tenantId = "33333333-3333-3333-3333-333333333333", displayName = "Fabrikam" },
    ]
  }
}

run "rejects_the_legacy_tenant_id" {
  command = plan
  variables {
    identity_sources = [
      { type = "tenant", tenantId = "33333333-3333-3333-3333-333333333333", tenant_id = "33333333-3333-3333-3333-333333333333" },
    ]
  }
  expect_failures = [var.identity_sources]
}

run "rejects_the_legacy_domain_name" {
  command = plan
  variables {
    identity_sources = [
      { type = "domain", domainName = "fabrikam.example", domain_name = "fabrikam.example" },
    ]
  }
  expect_failures = [var.identity_sources]
}

run "rejects_the_legacy_display_name" {
  command = plan
  variables {
    identity_sources = [
      { type = "tenant", tenantId = "33333333-3333-3333-3333-333333333333", display_name = "Fabrikam" },
    ]
  }
  expect_failures = [var.identity_sources]
}

run "an_explicit_null_legacy_value_is_accepted" {
  command = plan
  variables {
    identity_sources = [
      { type = "tenant", tenantId = "33333333-3333-3333-3333-333333333333", tenant_id = null, domain_name = null, display_name = null },
    ]
  }
}
