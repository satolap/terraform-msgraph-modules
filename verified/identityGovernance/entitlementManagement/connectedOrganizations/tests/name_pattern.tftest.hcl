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

  # By default the tenant holds no other connected organization, and a tenant
  # lookup finds the tenant below. Each data source reads only its own keys.
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
  identity_sources = [
    { type = "tenant", tenantId = "33333333-3333-3333-3333-333333333333", displayName = "Fabrikam" },
  ]
}

# name_pattern: optional, null by default. When set, display_name must match it
# or the plan fails. The pattern uses placeholder segments, not a real convention.

run "accepts_any_display_name_without_name_pattern" {
  command = apply

  variables {
    displayName = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.this.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any display_name must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = apply

  variables {
    displayName  = "Example ORG-DEV-Name"
    name_pattern = "ORG-(DEV|PRD)-"
  }

  assert {
    condition     = msgraph_resource.this.body.displayName == "Example ORG-DEV-Name"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    displayName  = "Example without the prefix"
    name_pattern = "^ORG-(DEV|PRD)-"
  }

  expect_failures = [msgraph_resource.this]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(unclosed"
  }

  expect_failures = [var.name_pattern]
}
