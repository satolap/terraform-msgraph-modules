locals {
  odata_types = {
    tenant        = "#microsoft.graph.azureActiveDirectoryTenant"
    tenant_domain = "#microsoft.graph.azureActiveDirectoryTenant"
    domain        = "#microsoft.graph.domainIdentitySource"
  }

  # The domain names that the tenant lookup resolves, in lower case. A domain name
  # has no case, so a change of case alone reads the same lookup.
  tenant_domains = toset([for s in var.identity_sources : lower(s.domain_name) if s.type == "tenant_domain" && s.domain_name != null])

  # The tenant that the lookup found for each of those domains. The lookup's
  # postcondition fails the plan when it returned no tenant ID.
  resolved_tenants = {
    for domain, lookup in data.msgraph_resource.tenant_by_domain : domain => {
      tenant_id    = try(lower(lookup.output.tenant_id), null)
      display_name = try(lookup.output.display_name, null)
    }
  }

  # One identity source per entry, in the order of identity_sources. Tenant IDs and
  # domain names are sent in lower case. A tenant display name is sent only when it
  # is known: an omitted key is not compared with what Graph returns.
  identity_sources_body = [
    for s in var.identity_sources : merge(
      { "@odata.type" = lookup(local.odata_types, s.type, null) },
      s.type == "tenant" ? merge(
        { tenantId = try(lower(s.tenant_id), null) },
        s.display_name == null ? {} : { displayName = s.display_name },
      ) : {},
      s.type == "tenant_domain" ? merge(
        { tenantId = try(local.resolved_tenants[lower(s.domain_name)].tenant_id, null) },
        try(local.resolved_tenants[lower(s.domain_name)].display_name, null) == null ? {} : { displayName = local.resolved_tenants[lower(s.domain_name)].display_name },
      ) : {},
      s.type == "domain" ? {
        domainName  = try(lower(s.domain_name), null)
        displayName = s.display_name == null ? try(lower(s.domain_name), null) : s.display_name
      } : {},
    )
  ]

  # Every managed key is in the body, on create and on update. The provider sends
  # an update as a PATCH of the changed top-level keys only, and Microsoft Graph
  # keeps the properties that a PATCH omits, so a description that is no longer
  # configured is sent as null rather than left out. A changed identity source list
  # is sent whole.
  body = {
    displayName     = var.display_name
    description     = var.description
    state           = var.state
    identitySources = local.identity_sources_body
  }

  # The tenants and domains that this organization names, in lower case. A
  # "tenant_domain" source counts with its tenant ID and its domain name.
  claimed_tenant_ids   = [for s in local.identity_sources_body : s.tenantId if lookup(s, "tenantId", null) != null]
  claimed_domain_names = [for s in var.identity_sources : lower(s.domain_name) if s.domain_name != null]

  # The connected organizations of the tenant as of the plan, with the tenant IDs
  # and domain names of their identity sources in lower case. The read is a tuple
  # whose elements can differ in type (an organization without identity sources
  # has null lists), and a conditional such as "x == null ? [] : x" cannot unify
  # such a tuple with an empty list. So the elements are reached by index:
  # length() of a null or a missing key fails inside try() and counts as zero, and
  # a null id, name, state or list entry falls back to a value that matches
  # nothing.
  listed_organizations_read = try(data.msgraph_resource.connected_organizations.output.organizations, null)
  listed_organizations = [
    for i in range(try(length(local.listed_organizations_read), 0)) : {
      id           = try(lower(local.listed_organizations_read[i].id), "")
      display_name = try(coalesce(local.listed_organizations_read[i].display_name, ""), "")
      state        = try(coalesce(local.listed_organizations_read[i].state, "unknown"), "unknown")
      tenant_ids   = [for j in range(try(length(local.listed_organizations_read[i].tenant_ids), 0)) : try(lower(local.listed_organizations_read[i].tenant_ids[j]), "")]
      domain_names = [for j in range(try(length(local.listed_organizations_read[i].domain_names), 0)) : try(lower(local.listed_organizations_read[i].domain_names[j]), "")]
    }
  ]

  # The listed organizations that name one of the same tenants or domains, with
  # the values they share. This list does not depend on this organization's own
  # ID, so it is known during every plan.
  claiming_organizations = [
    for o in local.listed_organizations : merge(o, {
      shared = concat(
        [for t in o.tenant_ids : t if contains(local.claimed_tenant_ids, t)],
        [for d in o.domain_names : d if contains(local.claimed_domain_names, d)],
      )
    }) if anytrue([for t in o.tenant_ids : contains(local.claimed_tenant_ids, t)]) || anytrue([for d in o.domain_names : contains(local.claimed_domain_names, d)])
  ]

  # The same list without this organization itself. While the organization is not
  # created yet its ID is unknown, so the list is unknown only when another
  # organization names one of the same tenants or domains.
  conflicting_organizations = [for o in local.claiming_organizations : o if o.id != lower(msgraph_resource.this.id)]

  # The sponsors as managed, in lower case, or null when a relationship is not
  # managed.
  internal_sponsor_ids = var.internal_sponsor_ids == null ? null : [for id in var.internal_sponsor_ids : lower(id)]
  external_sponsor_ids = var.external_sponsor_ids == null ? null : [for id in var.external_sponsor_ids : lower(id)]

  replication_delay_errors = [
    "does not exist or one of its queried reference-property objects are not present",
    "The source resource object or one of the objects being referenced",
  ]
}

# Resolves each "tenant_domain" source to its tenant. Microsoft Learn documents the
# function and its 200 response; it does not document the response for a domain
# that belongs to no tenant. Any error fails the plan, because a data source has
# no not-found tolerance. The domain name is validated, so it cannot carry a quote
# into the function parameter.
data "msgraph_resource" "tenant_by_domain" {
  for_each = local.tenant_domains

  url         = "tenantRelationships/findTenantInformationByDomainName(domainName='${each.key}')"
  api_version = "v1.0"

  response_export_values = {
    tenant_id    = "tenantId"
    display_name = "displayName"
  }

  lifecycle {
    postcondition {
      condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", self.output.tenant_id))
      error_message = "The tenant lookup for domain ${each.key} returned no tenant ID. If the domain belongs to no Microsoft Entra tenant, use type \"domain\" for it."
    }
  }
}

# Lists the connected organizations of the tenant for the
# identity_source_conflicts check. It is a top-level data source, not one inside
# the check block, so that a 401 or 403 fails the plan instead of reading as "no
# organizations". Microsoft Learn documents a $filter for one tenant ID but none
# for a domain name, so the module reads the whole list (the provider follows
# the next links) and selects only the properties that the check needs.
data "msgraph_resource" "connected_organizations" {
  url         = "identityGovernance/entitlementManagement/connectedOrganizations"
  api_version = "v1.0"

  query_parameters = {
    "$select" = ["id", "displayName", "state", "identitySources"]
  }

  response_export_values = {
    organizations = "value[].{id: id, display_name: displayName, state: state, tenant_ids: identitySources[].tenantId, domain_names: identitySources[].domainName}"
  }
}

# Microsoft Learn documents every managed property as updatable with a PATCH, the
# identity sources included, so a change updates the organization in place and its
# ID, which assignment policies reference, stays the same.
resource "msgraph_resource" "this" {
  url           = "identityGovernance/entitlementManagement/connectedOrganizations"
  api_version   = "v1.0"
  body          = local.body
  update_method = "PATCH"

  # Learn's get example returns an identity source without a tenantId. A key that
  # the read does not return keeps its configured value instead of showing as a
  # permanent change; a key that Graph returns with another value still shows.
  ignore_missing_property = true

  lifecycle {
    precondition {
      condition     = length(distinct(local.claimed_tenant_ids)) == length(local.claimed_tenant_ids)
      error_message = "identity_sources name the same Microsoft Entra tenant more than once: ${join(", ", sort(distinct([for t in local.claimed_tenant_ids : t if length([for u in local.claimed_tenant_ids : u if u == t]) > 1])))}. A \"tenant_domain\" source resolves to its tenant ID, so it must not name a tenant that another source names. Keep one source per tenant."
    }
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
  }
}

# The sponsors are $ref relationships. Each list is managed by its own collection
# only when it is set; a null list leaves the relationship alone. The provider
# adds a sponsor as {"@odata.id": "https://graph.microsoft.com/v1.0/directoryObjects/<id>"}
# and removes it with a DELETE of .../<id>/$ref. collection_type is left unset:
# releases before 0.6.0 do not have it and always use directoryObjects, which is
# also its default. A sponsor group created in the same apply can be missing from
# the replica that serves the add request, and Learn says to retry such a request
# after a delay, so both collections retry when Graph reports a directory object
# that does not exist yet or the replication message documented for group members.
# An expression stops before an apostrophe, which a JSON body may carry escaped.
resource "msgraph_resource_collection" "internal_sponsors" {
  count = local.internal_sponsor_ids == null ? 0 : 1

  url           = "identityGovernance/entitlementManagement/connectedOrganizations/${msgraph_resource.this.id}/internalSponsors/$ref"
  api_version   = "v1.0"
  reference_ids = local.internal_sponsor_ids

  retry = {
    error_message_regex = local.replication_delay_errors
  }
}

resource "msgraph_resource_collection" "external_sponsors" {
  count = local.external_sponsor_ids == null ? 0 : 1

  url           = "identityGovernance/entitlementManagement/connectedOrganizations/${msgraph_resource.this.id}/externalSponsors/$ref"
  api_version   = "v1.0"
  reference_ids = local.external_sponsor_ids

  retry = {
    error_message_regex = local.replication_delay_errors
  }
}

# Warns, without failing the plan or apply, when another connected organization
# names one of the tenants or domains of this one. Microsoft Learn does not say
# whether Graph rejects such a duplicate, and documents that Graph itself can
# create a proposed organization for a domain that a configured organization for a
# tenant already covers, so a failure would block every later change to this
# module until someone removes an organization that Graph created. A precondition
# also cannot leave out this organization: a resource cannot refer to itself, and
# on a create its ID is not known. On a plan that creates the organization the
# check is known when no other organization names one of its tenants or domains,
# and otherwise Terraform warns that the result is known after apply.
check "identity_source_conflicts" {
  assert {
    condition     = length(local.conflicting_organizations) == 0
    error_message = "Other connected organizations already name a tenant or domain of this organization: ${join("; ", [for o in local.conflicting_organizations : "\"${o.display_name}\" (${o.state}, ID ${o.id}) names ${join(", ", o.shared)}"])}. Two organizations for the same tenant or domain make it unclear which one a requestor belongs to, and whether Microsoft Graph accepts them is not documented. Remove the tenant or domain from one of them, or manage the existing organization with this module by importing it."
  }
}
