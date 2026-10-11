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
  display_name = "Fabrikam"
  identity_sources = [
    { type = "tenant", tenant_id = "33333333-3333-3333-3333-333333333333", display_name = "Fabrikam" },
  ]
}

# The runs below share one state in file order: the first apply run creates the
# organization, later runs update it. A replacement would take the id of the
# override_resource block; an in-place update keeps the id in the state.

# A plan that creates the organization knows the conflict check when no other
# organization names one of its tenants or domains, although its own id is not
# known yet.
run "a_create_plan_knows_the_conflict_check_when_nothing_else_claims_the_sources" {
  command = plan

  override_data {
    target = data.msgraph_resource.connected_organizations
    values = {
      output = {
        organizations = [
          { id = "55555555-5555-5555-5555-555555555555", display_name = "Contoso", state = "configured", tenant_ids = ["66666666-6666-6666-6666-666666666666"], domain_names = [] },
          { id = "77777777-7777-7777-7777-777777777777", display_name = "example.com", state = "proposed", tenant_ids = [], domain_names = ["example.com"] },
        ]
      }
    }
  }

  assert {
    condition     = length(local.claiming_organizations) == 0 && length(local.conflicting_organizations) == 0
    error_message = "Organizations that name other tenants and domains must not be reported, and the result must be known during the plan."
  }

  assert {
    condition     = jsonencode(local.claimed_tenant_ids) == jsonencode(["33333333-3333-3333-3333-333333333333"]) && length(local.claimed_domain_names) == 0
    error_message = "A tenant source must claim its tenant ID and no domain."
  }
}

run "tenant_source_renders_the_body" {
  command = apply

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/connectedOrganizations" && msgraph_resource.this.api_version == "v1.0"
    error_message = "The organization must be created in the connectedOrganizations collection on v1.0."
  }

  assert {
    condition     = msgraph_resource.this.update_method == "PATCH"
    error_message = "Microsoft Learn documents PATCH to update a connected organization."
  }

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "ignore_missing_property must be true, so that an identity source key that a read does not return is not a permanent change."
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body) == jsonencode({
      displayName = "Fabrikam"
      description = null
      state       = "configured"
      identitySources = [
        {
          "@odata.type" = "#microsoft.graph.azureActiveDirectoryTenant"
          displayName   = "Fabrikam"
          tenantId      = "33333333-3333-3333-3333-333333333333"
        },
      ]
    })
    error_message = "The body must carry the name, a null description, the configured state and the tenant identity source with its name."
  }

  assert {
    condition     = data.msgraph_resource.connected_organizations.url == "identityGovernance/entitlementManagement/connectedOrganizations" && data.msgraph_resource.connected_organizations.api_version == "v1.0"
    error_message = "The connected organizations must be listed from the same collection on v1.0."
  }

  assert {
    condition     = jsonencode(data.msgraph_resource.connected_organizations.query_parameters) == jsonencode({ "$select" = ["id", "displayName", "state", "identitySources"] })
    error_message = "The listing must select only the properties that the conflict check needs, and must not filter."
  }

  assert {
    condition     = length(data.msgraph_resource.tenant_by_domain) == 0
    error_message = "Without a tenant_domain source the module must not look up a tenant."
  }

  assert {
    condition     = length(msgraph_resource_collection.internal_sponsors) == 0 && length(msgraph_resource_collection.external_sponsors) == 0
    error_message = "Null sponsor lists must not create a sponsor collection."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222" && output.display_name == "Fabrikam" && output.state == "configured"
    error_message = "id must come from the resource, and display_name and state from the inputs."
  }

  assert {
    condition     = jsonencode(output.identity_sources) == jsonencode(msgraph_resource.this.body.identitySources)
    error_message = "identity_sources must be the identity sources as sent."
  }

  assert {
    condition     = output.internal_sponsor_ids == null && output.external_sponsor_ids == null
    error_message = "Unmanaged sponsor relationships must be output as null."
  }
}

# A caller puts the organization into an assignment policy's specific_allowed_targets.
run "specific_allowed_target_fits_an_assignment_policy" {
  command = apply

  assert {
    condition     = jsonencode(output.specific_allowed_target) == jsonencode({ id = "22222222-2222-2222-2222-222222222222", type = "connectedOrganizationMembers" })
    error_message = "specific_allowed_target must hold the connectedOrganizationMembers type and the organization's id."
  }
}

run "a_tenant_without_a_display_name_sends_no_name" {
  command = apply

  variables {
    identity_sources = [
      { type = "tenant", tenant_id = "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE" },
    ]
  }

  # A new object would take this id; an in-place update keeps the old one.
  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000001"
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body.identitySources) == jsonencode([
      {
        "@odata.type" = "#microsoft.graph.azureActiveDirectoryTenant"
        tenantId      = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
      },
    ])
    error_message = "A tenant source without display_name must send no displayName, and its tenant ID in lower case."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Changing the identity sources must update the organization in place and keep its id."
  }
}

run "a_domain_source_defaults_its_display_name_to_the_domain" {
  command = apply

  variables {
    identity_sources = [
      { type = "domain", domain_name = "Example.COM" },
    ]
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000002"
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body.identitySources) == jsonencode([
      {
        "@odata.type" = "#microsoft.graph.domainIdentitySource"
        displayName   = "example.com"
        domainName    = "example.com"
      },
    ])
    error_message = "A domain source must send the domain name in lower case and use it as the default display name."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Changing a tenant source to a domain source must update the organization in place and keep its id."
  }

  assert {
    condition     = length(local.claimed_tenant_ids) == 0 && jsonencode(local.claimed_domain_names) == jsonencode(["example.com"])
    error_message = "A domain source must claim its domain name and no tenant."
  }
}

run "a_domain_source_sends_its_display_name" {
  command = apply

  variables {
    identity_sources = [
      { type = "domain", domain_name = "example.com", display_name = "Example partners" },
    ]
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body.identitySources) == jsonencode([
      {
        "@odata.type" = "#microsoft.graph.domainIdentitySource"
        displayName   = "Example partners"
        domainName    = "example.com"
      },
    ])
    error_message = "A configured display name must replace the default."
  }
}

run "a_tenant_domain_source_is_resolved_by_the_lookup" {
  command = apply

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "Fabrikam.com" },
    ]
  }

  override_data {
    target = data.msgraph_resource.tenant_by_domain
    values = {
      output = {
        tenant_id    = "ABABABAB-ABAB-ABAB-ABAB-ABABABABABAB"
        display_name = "Fabrikam Ltd"
      }
    }
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000003"
    }
  }

  assert {
    condition     = jsonencode(keys(data.msgraph_resource.tenant_by_domain)) == jsonencode(["fabrikam.com"])
    error_message = "The lookup must be keyed by the domain name in lower case."
  }

  assert {
    condition     = data.msgraph_resource.tenant_by_domain["fabrikam.com"].url == "tenantRelationships/findTenantInformationByDomainName(domainName='fabrikam.com')" && data.msgraph_resource.tenant_by_domain["fabrikam.com"].api_version == "v1.0"
    error_message = "The tenant must be looked up with findTenantInformationByDomainName on v1.0."
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body.identitySources) == jsonencode([
      {
        "@odata.type" = "#microsoft.graph.azureActiveDirectoryTenant"
        displayName   = "Fabrikam Ltd"
        tenantId      = "abababab-abab-abab-abab-abababababab"
      },
    ])
    error_message = "A tenant_domain source must be sent as a tenant with the tenant ID, in lower case, and the name that the lookup returned."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "A resolved tenant source must update the organization in place and keep its id."
  }

  assert {
    condition     = jsonencode(local.claimed_tenant_ids) == jsonencode(["abababab-abab-abab-abab-abababababab"]) && jsonencode(local.claimed_domain_names) == jsonencode(["fabrikam.com"])
    error_message = "A tenant_domain source must claim both its resolved tenant ID and its domain name."
  }
}

run "a_lookup_without_a_tenant_name_sends_no_name" {
  command = apply

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "fabrikam.com" },
    ]
  }

  override_data {
    target = data.msgraph_resource.tenant_by_domain
    values = {
      output = {
        tenant_id    = "44444444-4444-4444-4444-444444444444"
        display_name = null
      }
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body.identitySources) == jsonencode([
      {
        "@odata.type" = "#microsoft.graph.azureActiveDirectoryTenant"
        tenantId      = "44444444-4444-4444-4444-444444444444"
      },
    ])
    error_message = "A lookup that returns no tenant name must send no displayName."
  }
}

# Graph's response for a domain without a tenant is not documented; a 404 or any
# other error fails the plan in the provider. A response without a tenant ID
# fails the lookup's postcondition.
run "a_lookup_without_a_tenant_id_fails_the_plan" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "fabrikam.com" },
    ]
  }

  override_data {
    target = data.msgraph_resource.tenant_by_domain
    values = {
      output = {
        tenant_id    = null
        display_name = "Fabrikam"
      }
    }
  }

  expect_failures = [data.msgraph_resource.tenant_by_domain]
}

run "several_sources_are_sent_in_order" {
  command = apply

  variables {
    identity_sources = [
      { type = "domain", domain_name = "example.com" },
      { type = "tenant", tenant_id = "33333333-3333-3333-3333-333333333333", display_name = "Contoso" },
      { type = "tenant_domain", domain_name = "fabrikam.com" },
    ]
  }

  override_resource {
    target = msgraph_resource.this
    values = {
      id = "22222222-2222-2222-2222-000000000004"
    }
  }

  assert {
    condition = jsonencode(msgraph_resource.this.body.identitySources) == jsonencode([
      {
        "@odata.type" = "#microsoft.graph.domainIdentitySource"
        displayName   = "example.com"
        domainName    = "example.com"
      },
      {
        "@odata.type" = "#microsoft.graph.azureActiveDirectoryTenant"
        displayName   = "Contoso"
        tenantId      = "33333333-3333-3333-3333-333333333333"
      },
      {
        "@odata.type" = "#microsoft.graph.azureActiveDirectoryTenant"
        displayName   = "Fabrikam"
        tenantId      = "44444444-4444-4444-4444-444444444444"
      },
    ])
    error_message = "Every source must be sent in the order of identity_sources, each with its own shape."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Adding identity sources must update the organization in place and keep its id."
  }
}

run "description_and_state_are_sent" {
  command = apply

  variables {
    description = "Partner organization"
    state       = "proposed"
  }

  assert {
    condition     = msgraph_resource.this.body.description == "Partner organization" && msgraph_resource.this.body.state == "proposed" && output.state == "proposed"
    error_message = "A configured description and state must be sent and the state output."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "A description or state change must update the organization in place and keep its id."
  }
}

# A PATCH keeps omitted properties, so a description can only be cleared by
# sending it. Whether Microsoft Graph accepts the null is not verified.
run "a_cleared_description_is_sent_as_null" {
  command = apply

  assert {
    condition     = contains(keys(msgraph_resource.this.body), "description") && msgraph_resource.this.body.description == null
    error_message = "A description that is no longer configured must still be in the body, as null."
  }

  assert {
    condition     = msgraph_resource.this.body.state == "configured"
    error_message = "state must default to configured."
  }
}

# Sponsors
run "internal_sponsors_are_managed_by_a_ref_collection" {
  command = apply

  variables {
    internal_sponsor_ids = ["88888888-8888-8888-8888-888888888888", "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE"]
  }

  assert {
    condition     = length(msgraph_resource_collection.internal_sponsors) == 1 && length(msgraph_resource_collection.external_sponsors) == 0
    error_message = "Only the configured relationship must get a collection."
  }

  assert {
    condition     = msgraph_resource_collection.internal_sponsors[0].url == "identityGovernance/entitlementManagement/connectedOrganizations/22222222-2222-2222-2222-222222222222/internalSponsors/$ref" && msgraph_resource_collection.internal_sponsors[0].api_version == "v1.0"
    error_message = "The internal sponsors must be managed through the internalSponsors $ref collection of the organization on v1.0."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.internal_sponsors[0].reference_ids) == jsonencode(["88888888-8888-8888-8888-888888888888", "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"])
    error_message = "The sponsor ids must be managed in lower case, in the configured order."
  }

  assert {
    condition     = jsonencode(output.internal_sponsor_ids) == jsonencode(["88888888-8888-8888-8888-888888888888", "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"]) && output.external_sponsor_ids == null
    error_message = "The managed sponsors must be output, and the unmanaged relationship as null."
  }

  assert {
    condition     = output.id == "22222222-2222-2222-2222-222222222222"
    error_message = "Managing sponsors must not change the organization."
  }
}

run "external_sponsors_are_managed_by_a_ref_collection" {
  command = apply

  variables {
    internal_sponsor_ids = ["88888888-8888-8888-8888-888888888888", "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"]
    external_sponsor_ids = ["99999999-9999-9999-9999-999999999999"]
  }

  assert {
    condition     = length(msgraph_resource_collection.external_sponsors) == 1 && msgraph_resource_collection.external_sponsors[0].url == "identityGovernance/entitlementManagement/connectedOrganizations/22222222-2222-2222-2222-222222222222/externalSponsors/$ref" && msgraph_resource_collection.external_sponsors[0].api_version == "v1.0"
    error_message = "The external sponsors must be managed through the externalSponsors $ref collection of the organization on v1.0."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.external_sponsors[0].reference_ids) == jsonencode(["99999999-9999-9999-9999-999999999999"]) && jsonencode(output.external_sponsor_ids) == jsonencode(["99999999-9999-9999-9999-999999999999"])
    error_message = "The external sponsor ids must be managed and output."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.internal_sponsors[0].reference_ids) == jsonencode(["88888888-8888-8888-8888-888888888888", "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"])
    error_message = "A change of case alone must not change the managed internal sponsors."
  }
}

run "an_empty_list_removes_every_sponsor" {
  command = apply

  variables {
    internal_sponsor_ids = []
    external_sponsor_ids = ["99999999-9999-9999-9999-999999999999"]
  }

  assert {
    condition     = length(msgraph_resource_collection.internal_sponsors) == 1 && length(msgraph_resource_collection.internal_sponsors[0].reference_ids) == 0
    error_message = "An empty list must keep the collection, with no reference, so that every internal sponsor is removed."
  }

  assert {
    condition     = jsonencode(output.internal_sponsor_ids) == jsonencode([])
    error_message = "An empty managed list must be output as an empty list, not null."
  }
}

run "null_sponsor_lists_leave_the_relationships_unmanaged" {
  command = apply

  assert {
    condition     = length(msgraph_resource_collection.internal_sponsors) == 0 && length(msgraph_resource_collection.external_sponsors) == 0
    error_message = "Null sponsor lists must remove the collections from the configuration."
  }

  assert {
    condition     = output.internal_sponsor_ids == null && output.external_sponsor_ids == null
    error_message = "Unmanaged sponsor relationships must be output as null."
  }
}

# identity_source_conflicts. The state holds the id 22222222-...; the listing
# returns ids in upper case to show that the comparison ignores case.
run "does_not_report_itself_or_unrelated_organizations" {
  command = apply

  override_data {
    target = data.msgraph_resource.connected_organizations
    values = {
      output = {
        organizations = [
          { id = "22222222-2222-2222-2222-222222222222", display_name = "Fabrikam", state = "configured", tenant_ids = ["33333333-3333-3333-3333-333333333333"], domain_names = [] },
          { id = "55555555-5555-5555-5555-555555555555", display_name = "Contoso", state = "configured", tenant_ids = ["66666666-6666-6666-6666-666666666666"], domain_names = ["contoso.com"] },
          { id = "77777777-7777-7777-7777-777777777777", display_name = "Empty", state = "proposed", tenant_ids = null, domain_names = null },
          { id = "88888888-8888-8888-8888-888888888888", display_name = null },
        ]
      }
    }
  }

  assert {
    condition     = jsonencode([for o in local.claiming_organizations : o.id]) == jsonencode(["22222222-2222-2222-2222-222222222222"])
    error_message = "Only the organization itself names the tenant."
  }

  assert {
    condition     = length(local.conflicting_organizations) == 0
    error_message = "The organization itself, organizations with other sources and organizations without sources must not be reported."
  }
}

run "warns_when_another_organization_names_the_tenant" {
  command = apply

  override_data {
    target = data.msgraph_resource.connected_organizations
    values = {
      output = {
        organizations = [
          { id = "22222222-2222-2222-2222-222222222222", display_name = "Fabrikam", state = "configured", tenant_ids = ["33333333-3333-3333-3333-333333333333"], domain_names = [] },
          { id = "55555555-5555-5555-5555-555555555555", display_name = "Fabrikam (old)", state = "proposed", tenant_ids = ["33333333-3333-3333-3333-333333333333"], domain_names = [] },
        ]
      }
    }
  }

  expect_failures = [check.identity_source_conflicts]

  assert {
    condition     = jsonencode([for o in local.conflicting_organizations : { id = o.id, state = o.state, shared = o.shared }]) == jsonencode([{ id = "55555555-5555-5555-5555-555555555555", state = "proposed", shared = ["33333333-3333-3333-3333-333333333333"] }])
    error_message = "The other organization that names the tenant must be reported with its state and the shared tenant ID."
  }
}

run "warns_when_another_organization_names_the_domain_in_another_case" {
  command = apply

  variables {
    identity_sources = [
      { type = "domain", domain_name = "example.com" },
    ]
  }

  override_data {
    target = data.msgraph_resource.connected_organizations
    values = {
      output = {
        organizations = [
          { id = "66666666-6666-6666-6666-666666666666", display_name = "Example", state = "configured", tenant_ids = [], domain_names = ["EXAMPLE.com"] },
        ]
      }
    }
  }

  expect_failures = [check.identity_source_conflicts]

  assert {
    condition     = jsonencode([for o in local.conflicting_organizations : o.shared]) == jsonencode([["example.com"]])
    error_message = "A domain must match whatever its case."
  }
}

# A tenant_domain source names its resolved tenant and its domain name.
run "a_tenant_domain_source_is_compared_by_its_tenant_and_its_domain" {
  command = apply

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "fabrikam.com" },
    ]
  }

  override_data {
    target = data.msgraph_resource.connected_organizations
    values = {
      output = {
        organizations = [
          { id = "55555555-5555-5555-5555-555555555555", display_name = "Fabrikam tenant", state = "configured", tenant_ids = ["44444444-4444-4444-4444-444444444444"], domain_names = [] },
          { id = "77777777-7777-7777-7777-777777777777", display_name = "fabrikam.com", state = "proposed", tenant_ids = [], domain_names = ["fabrikam.com"] },
        ]
      }
    }
  }

  expect_failures = [check.identity_source_conflicts]

  assert {
    condition     = jsonencode([for o in local.conflicting_organizations : o.id]) == jsonencode(["55555555-5555-5555-5555-555555555555", "77777777-7777-7777-7777-777777777777"])
    error_message = "Both the organization for the resolved tenant and the one for the domain must be reported."
  }
}

# Two sources that resolve to the same tenant are rejected before any request.
run "rejects_two_sources_for_the_same_tenant" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant", tenant_id = "44444444-4444-4444-4444-444444444444" },
      { type = "tenant_domain", domain_name = "fabrikam.com" },
    ]
  }

  expect_failures = [msgraph_resource.this]
}

# Validation. Each run changes one input and expects its variable to fail.
run "rejects_an_empty_display_name" {
  command = plan

  variables {
    display_name = ""
  }

  expect_failures = [var.display_name]
}

run "rejects_a_blank_display_name" {
  command = plan

  variables {
    display_name = "   "
  }

  expect_failures = [var.display_name]
}

run "rejects_an_unknown_state" {
  command = plan

  variables {
    state = "unknownFutureValue"
  }

  expect_failures = [var.state]
}

run "rejects_no_identity_source" {
  command = plan

  variables {
    identity_sources = []
  }

  expect_failures = [var.identity_sources]
}

run "rejects_an_unsupported_identity_source_type" {
  command = plan

  variables {
    identity_sources = [
      { type = "crossCloudAzureActiveDirectoryTenant", tenant_id = "33333333-3333-3333-3333-333333333333" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_tenant_without_a_tenant_id" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_tenant_id_that_is_not_a_guid" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant", tenant_id = "fabrikam.com" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_tenant_id_on_a_domain_source" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", domain_name = "example.com", tenant_id = "33333333-3333-3333-3333-333333333333" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_tenant_id_on_a_tenant_domain_source" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "fabrikam.com", tenant_id = "44444444-4444-4444-4444-444444444444" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_domain_name_on_a_tenant_source" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant", tenant_id = "33333333-3333-3333-3333-333333333333", domain_name = "fabrikam.com" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_tenant_domain_source_without_a_domain_name" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant_domain" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_domain_source_without_a_domain_name" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", display_name = "Example" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_domain_name_with_a_scheme" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", domain_name = "https://example.com" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_an_email_address_as_a_domain_name" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", domain_name = "partner@example.com" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_domain_name_with_one_label" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", domain_name = "example" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_domain_name_with_a_trailing_dot" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", domain_name = "example.com." },
    ]
  }

  expect_failures = [var.identity_sources]
}

# The domain name is placed inside the quotes of the lookup's function parameter.
run "rejects_a_domain_name_with_a_quote" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "fabrikam.com')" },
    ]
  }

  expect_failures = [var.identity_sources]
}

# 4 labels of 63 characters and 3 dots make 255 characters.
run "rejects_a_domain_name_over_253_characters" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", domain_name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_display_name_on_a_tenant_domain_source" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "fabrikam.com", display_name = "Fabrikam" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_a_blank_source_display_name" {
  command = plan

  variables {
    identity_sources = [
      { type = "domain", domain_name = "example.com", display_name = " " },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_the_same_tenant_id_twice_in_another_case" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant", tenant_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee" },
      { type = "tenant", tenant_id = "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_the_same_domain_for_two_types" {
  command = plan

  variables {
    identity_sources = [
      { type = "tenant_domain", domain_name = "fabrikam.com" },
      { type = "domain", domain_name = "Fabrikam.com" },
    ]
  }

  expect_failures = [var.identity_sources]
}

run "rejects_an_internal_sponsor_id_that_is_not_a_guid" {
  command = plan

  variables {
    internal_sponsor_ids = ["partner@example.com"]
  }

  expect_failures = [var.internal_sponsor_ids]
}

run "rejects_the_same_internal_sponsor_twice" {
  command = plan

  variables {
    internal_sponsor_ids = ["aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee", "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE"]
  }

  expect_failures = [var.internal_sponsor_ids]
}

run "rejects_an_external_sponsor_id_that_is_not_a_guid" {
  command = plan

  variables {
    external_sponsor_ids = ["not-a-guid"]
  }

  expect_failures = [var.external_sponsor_ids]
}

run "rejects_the_same_external_sponsor_twice" {
  command = plan

  variables {
    external_sponsor_ids = ["99999999-9999-9999-9999-999999999999", "99999999-9999-9999-9999-999999999999"]
  }

  expect_failures = [var.external_sponsor_ids]
}
