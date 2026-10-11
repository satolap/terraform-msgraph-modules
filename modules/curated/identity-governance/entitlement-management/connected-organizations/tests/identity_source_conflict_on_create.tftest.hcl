# A separate file starts from an empty state, so its run creates the organization.
# Another organization already names the same tenant. On the plan that creates
# the organization the conflict check is known only after apply, because the new
# organization's id is not known yet; in a terraform test plan run that is an
# error, so this run applies. After the apply the check warns, reading the listing
# that the plan took before the organization existed.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "22222222-2222-2222-2222-222222222222"
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        organizations = [
          { id = "55555555-5555-5555-5555-555555555555", display_name = "Fabrikam", state = "proposed", tenant_ids = ["33333333-3333-3333-3333-333333333333"], domain_names = null },
        ]
      }
    }
  }
}

variables {
  display_name = "Fabrikam"
  identity_sources = [
    { type = "tenant", tenant_id = "33333333-3333-3333-3333-333333333333" },
  ]
}

run "a_create_warns_after_the_apply_when_another_organization_names_the_tenant" {
  command = apply

  expect_failures = [check.identity_source_conflicts]

  assert {
    condition     = jsonencode([for o in local.conflicting_organizations : { id = o.id, display_name = o.display_name, shared = o.shared }]) == jsonencode([{ display_name = "Fabrikam", id = "55555555-5555-5555-5555-555555555555", shared = ["33333333-3333-3333-3333-333333333333"] }])
    error_message = "After the create the other organization that names the tenant must be reported."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "The check must only warn: the organization is still created."
  }
}
