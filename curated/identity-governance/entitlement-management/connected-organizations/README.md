# identity-governance/entitlement-management/connected-organizations

Manages one Microsoft Entra ID Governance entitlement management **connected organization**
(`identityGovernance/entitlementManagement/connectedOrganizations`) and, when you ask for them,
its internal and external sponsors, via the `microsoft/msgraph` Terraform provider. A connected
organization is the Microsoft Entra tenant or the domain of another organization whose users can
request access packages; an assignment policy lets them request by naming the organization. The
folder mirrors the Graph collection it manages.

What the module manages, and what it does not:

- **Typed identity sources.** `identity_sources` names the tenants and domains of the
  organization, each as a `tenant` (by tenant ID), a `tenant_domain` (a tenant that the module
  looks up by one of its domain names during the plan) or a `domain` (a domain whose users sign
  in with a one-time passcode). See [Identity sources](#identity-sources).
- **Every managed key is in the body,** on create and on update: display name, description,
  state and identity sources. Microsoft Learn documents `PATCH` for the update and says that
  properties the body omits keep their previous values, so the module sends `description` as
  `null` rather than leaving it out.
- **Updates in place.** Learn lists `displayName`, `description`, `identitySources` and `state`
  as updatable, so every change, a change of identity sources included, keeps the organization
  and its ID, which assignment policies reference. Nothing replaces the organization.
- **Sponsors, when you set them.** `internal_sponsor_ids` and `external_sponsor_ids` default to
  `null`, which leaves the sponsors alone. A list is authoritative and managed through the
  sponsor `$ref` relationship. See [Sponsors](#sponsors).
- **Conflicts are reported.** The `identity_source_conflicts` check warns when another connected
  organization names one of the same tenants or domains.
- **Not managed here:** the guests and their invitations, cross-tenant access and external
  collaboration settings, and the access packages and policies that target the organization.
  Cross-cloud tenants, SAML/WS-Fed federated domains and social identity sources are not
  supported.
- v1.0 only. There is no `api_version` input.

## When to use this module instead of a generated one

As published when this module was written, the generated module for the same collection
(`modules/generated/v1.0/identity-and-access/identity-governance/entitlement-management/connected-organizations`)
types each element of `identity_sources` as an object with only `odata_type`. A Terraform
object keeps only its declared attributes, so the `tenantId`, `domainName` and `displayName`
of an identity source are dropped, and the generated module cannot say which tenant or domain
the organization stands for. It also cannot manage sponsors: it types `internal_sponsors` and
`external_sponsors` as directory objects with only `@odata.type` and `deletedDateTime` in the
request body, while Learn adds and removes sponsors one reference at a time through the
`internalSponsors/$ref` and `externalSponsors/$ref` relationships. Its `state` is untyped.
Prefer this module: its identity sources are typed and can be looked up by domain, its
sponsors are managed through the `$ref` relationships, and it warns about conflicting
organizations.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "fabrikam" {
  source  = "satolap/modules/msgraph//curated/identity-governance/entitlement-management/connected-organizations"
  version = "<version>"

  display_name = "Fabrikam"
  description  = "Fabrikam partner organization"

  identity_sources = [
    { type = "tenant_domain", domain_name = "fabrikam.com" },
  ]

  internal_sponsor_ids = [module.partner_managers.id]
  external_sponsor_ids = [var.fabrikam_contact_guest_id]
}
```

An organization whose users have no Microsoft Entra tenant is a domain:

```hcl
module "example_partner" {
  source  = "satolap/modules/msgraph//curated/identity-governance/entitlement-management/connected-organizations"
  version = "<version>"

  display_name     = "Example partner"
  identity_sources = [{ type = "domain", domain_name = "example.com" }]
}
```

`specific_allowed_target` holds the organization in the shape of one element of the
`specific_allowed_targets` input of the assignment policy module. Its sponsors can approve the
requests of its users:

```hcl
module "fabrikam_policy" {
  source  = "satolap/modules/msgraph//curated/identity-governance/entitlement-management/assignment-policies"
  version = "<version>"

  access_package_id        = module.partner_access.id
  display_name             = "Fabrikam requests"
  allowed_target_scope     = "specificConnectedOrganizationUsers"
  specific_allowed_targets = [module.fabrikam.specific_allowed_target]

  request_approval_settings = {
    is_approval_required_for_add = true
    stages = [
      {
        primary_approvers          = [{ type = "externalSponsors" }]
        fallback_primary_approvers = [{ type = "internalSponsors" }]
      },
    ]
  }
}
```

With the values above `specific_allowed_target` is
`{ type = "connectedOrganizationMembers", id = "<organization id>" }`.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.5.0 |

Terraform 1.5 is the first version with `check` blocks. The offline test suite needs Terraform
1.7 or later. The module sets minimum versions only; set upper bounds in your root module.
`microsoft/msgraph` 0.5.0 is the first release that does not abort a sponsor collection with
"Provider produced inconsistent final plan" when its IDs mix values known during the plan
with values known only during the same apply
([0.5.0 changelog](https://github.com/microsoft/terraform-provider-msgraph/blob/main/CHANGELOG.md)).

| Operation | Least privileged application permission | Least privileged delegated role |
| --- | --- | --- |
| [Create](https://learn.microsoft.com/en-us/graph/api/entitlementmanagement-post-connectedorganizations?view=graph-rest-1.0), [update](https://learn.microsoft.com/en-us/graph/api/connectedorganization-update?view=graph-rest-1.0) and [delete](https://learn.microsoft.com/en-us/graph/api/connectedorganization-delete?view=graph-rest-1.0) the organization | `EntitlementManagement.ReadWrite.All` | Identity Governance Administrator |
| [Read](https://learn.microsoft.com/en-us/graph/api/connectedorganization-get?view=graph-rest-1.0) the organization, to refresh | `EntitlementManagement.Read.All` | Identity Governance Administrator |
| [List](https://learn.microsoft.com/en-us/graph/api/entitlementmanagement-list-connectedorganizations?view=graph-rest-1.0) the connected organizations, on every plan | `EntitlementManagement.Read.All` | Identity Governance Administrator |
| Add and remove [internal](https://learn.microsoft.com/en-us/graph/api/connectedorganization-post-internalsponsors?view=graph-rest-1.0) and [external](https://learn.microsoft.com/en-us/graph/api/connectedorganization-post-externalsponsors?view=graph-rest-1.0) sponsors ([remove internal](https://learn.microsoft.com/en-us/graph/api/connectedorganization-delete-internalsponsors?view=graph-rest-1.0), [remove external](https://learn.microsoft.com/en-us/graph/api/connectedorganization-delete-externalsponsors?view=graph-rest-1.0)), only when a sponsor list is set | `EntitlementManagement.ReadWrite.All` | Identity Governance Administrator |
| List the [internal](https://learn.microsoft.com/en-us/graph/api/connectedorganization-list-internalsponsors?view=graph-rest-1.0) and [external](https://learn.microsoft.com/en-us/graph/api/connectedorganization-list-externalsponsors?view=graph-rest-1.0) sponsors, to refresh, only when a sponsor list is set | `EntitlementManagement.Read.All` | Catalog reader |
| [Look up a tenant by domain name](https://learn.microsoft.com/en-us/graph/api/tenantrelationship-findtenantinformationbydomainname?view=graph-rest-1.0), only for `tenant_domain` sources | `CrossTenantInformation.ReadBasic.All` | None: Learn says the call needs no Microsoft Entra role |

- For the write operations Learn says an application can hold the Identity Governance
  Administrator role instead of `EntitlementManagement.ReadWrite.All`, and that the role is the
  less privileged of the two.
- The module lists the connected organizations on every plan, and looks up each
  `tenant_domain` source. A failed read (a `401`, a `403`, or a lookup that finds no tenant)
  fails the plan; it is not read as "no organizations" or "no tenant".
- Run Terraform for this module as a dedicated automation identity rather than as a person.
- Only Microsoft Graph v1.0 is supported.

## Identity sources

| `type` | Sent as | Set | Optional |
| --- | --- | --- | --- |
| `tenant` | `azureActiveDirectoryTenant` with `tenantId` and `displayName` | `tenant_id` | `display_name`; `displayName` is left out when it is null |
| `tenant_domain` | `azureActiveDirectoryTenant` with the `tenantId` and `displayName` that the lookup returns | `domain_name` | none |
| `domain` | `domainIdentitySource` with `domainName` and `displayName` | `domain_name` | `display_name`, which defaults to the domain name |

- **Looking a tenant up by domain.** Learn's second create example says the tenant ID can be
  found by domain name with
  `GET /tenantRelationships/findTenantInformationByDomainName(domainName='{domain}')`. A
  `tenant_domain` source does that during the plan, with a data source per domain name. Learn
  describes the parameter as the primary domain name of a tenant; whether other verified
  domains of the tenant resolve is not verified. Learn does not document the response for a
  domain that belongs to no tenant. A data source has no not-found tolerance, so any error
  fails the plan with the provider's message for that request, and a response without a
  tenant ID fails with the lookup's postcondition. Use `type = "domain"` for such a domain.
  The lookup runs on every plan, so a renamed tenant updates the identity source's name in
  place. The domain names of `tenant_domain` sources must be known at plan time.
- **Case.** Tenant IDs and domain names are sent in lower case, and the lookup is keyed by the
  domain name in lower case, so a change of case alone plans nothing.
- **Several identity sources** are sent in the order of `identity_sources`. Learn's create page
  describes the `identitySources` of a create request as a collection with one element, the
  initial identity source, while the admin center can add several directories and domains and
  the update page lists `identitySources` as updatable. Whether Graph accepts several identity
  sources in one create request is not verified. If it rejects them, create the organization
  with one and add the others in a second apply, which updates it.
- **Duplicates.** A tenant ID or a domain name can be named once. Two sources that resolve to
  the same tenant, such as a `tenant` and a `tenant_domain` source, fail the plan before any
  request is sent.
- **Not supported.** `crossCloudAzureActiveDirectoryTenant` (a tenant in another cloud): Learn
  shows no request that creates it, and the update page does not list it.
  `externalDomainFederation` (a domain with a SAML/WS-Fed identity provider): the federation is
  configured outside entitlement management, and Learn shows no request that creates it.
  `socialIdentitySource`: Learn shows no request that creates it, and warns against making a
  social source configured when a policy allows all configured organizations. Learn's resource
  pages call the properties of every identity source read-only, although its create examples
  send them; the module follows the create examples.

## Sponsors

- **null, a list or an empty list.** With `null`, the default, the module creates no sponsor
  resource and leaves the relationship alone. A list is authoritative: the provider's
  `msgraph_resource_collection` adds the sponsors that are missing and, from the next plan on,
  removes the others, including sponsors added in the admin center. An empty list removes every
  sponsor of that kind.
- **Requests.** The collection adds a sponsor with a `POST` of
  `{"@odata.id": "https://graph.microsoft.com/v1.0/directoryObjects/<id>"}` to
  `.../connectedOrganizations/{id}/internalSponsors/$ref` (or `externalSponsors`) and removes one
  with a `DELETE` of `.../internalSponsors/<id>/$ref`. Learn says the reference is the full URI of
  the user or group and shows a `users/{id}` URI in its example; whether Graph also accepts a
  typed `groups/{id}` URI is not documented. The `directoryObjects` URI names a user and a group
  alike. Every provider release sends it: releases before 0.6.0 always do, and 0.6.0 added
  `collection_type`, whose default is `directoryObjects`. The module leaves `collection_type`
  unset, the same URI on every release.
- **Who can be a sponsor.** Learn's add pages accept a user or a group. Its admin center guide
  describes internal sponsors as member users in your directory and external sponsors as guest
  users from the connected organization who were invited before, and says that sponsors can be
  the approvers of the requests of the organization's users (the `internalSponsors` and
  `externalSponsors` approver types of an assignment policy). The module checks neither the
  object type, nor the user type, nor whether a guest comes from the organization.
- **IDs** are managed in lower case, so a change of case alone plans nothing.
- **Replication delays are retried.** A sponsor group created in the same apply can be
  missing from the replica that serves the add request; Learn says to retry after a delay.
  The collections retry when Graph reports a directory object that does not exist yet or the
  replication message documented for group members, so an ID that really does not exist
  fails only when the provider's timeout runs out. The exact messages are not verified live.
- **Changing a list back to `null`** destroys its collection, and the provider then removes the
  sponsors that the module last managed. To stop managing them and keep them, remove the
  collection from the state first:
  `terraform state rm 'module.<name>.msgraph_resource_collection.internal_sponsors[0]'`.
- **Destroying the module** removes the managed sponsors first, then deletes the organization.

## Limits and lifecycle

- **An update is a PATCH of the changed keys.** The provider sends only the top-level keys that
  changed, and a changed identity source list whole. Whether Graph replaces the stored list
  with the one sent, as the admin center's "Update directory + domain" suggests, is not
  verified. Learn's update returns `202 Accepted`; the provider accepts it.
- **Drift.** `ignore_missing_property` is `true`: Learn's get example returns an identity
  source without a `tenantId`, and a key that a read does not return would otherwise show as a
  permanent change. A key that Graph returns with another value still shows as drift, so an
  identity source or name changed in the admin center plans an update that restores the
  configuration. Learn's get and list examples write the identity source's `@odata.type`
  without the leading `#`, and its create examples return an empty `identitySources` list. If
  Graph reads back either of those, the plan shows a change on every run; neither is verified.
- **A null description** is sent on create and on update. Whether Graph accepts it, and whether
  it reads back as `null` rather than as an empty string, is not verified.
- **State.** Learn says an organization created through the API should be `configured` unless
  it is set to another state explicitly, and that only configured organizations are in scope of
  policies that allow all configured connected organizations; a `proposed` one is in scope only
  of policies that name it. Graph creates proposed organizations itself when a policy lets
  users from any organization request access.
- **Conflicts warn, they do not fail.** `identity_source_conflicts` compares the tenant IDs and
  domain names of this organization (a `tenant_domain` source with both) with the tenant IDs and
  domain names of every other connected organization, ignoring case. It cannot tell that a
  domain belongs to a tenant that another organization names by its ID. Learn does not say
  whether Graph rejects two organizations with the same tenant or domain, and it documents that
  Graph can create a proposed organization for a domain that a configured organization for a
  tenant already covers. A failure would block every later change to this module until someone
  removed an organization that Graph created, so the check warns. A precondition could not
  leave this organization out of the comparison either: a resource cannot refer to itself, and
  its ID is not known before it is created. The listing is read during the plan. On a plan that
  creates the organization the check passes when no other organization names one of its
  tenants or domains, and otherwise Terraform warns that the result is known after apply; the
  check then warns after the apply. To move a tenant or domain from one organization to another,
  remove it from the first and apply, then add it to the second; in one apply the second warns.
- **Same Terraform state.** Keep the organization and the policies that target it in one state,
  so that Terraform deletes the policies first. Whether Graph deletes an organization that a
  policy still targets is not documented.
- **Tests that call this module.** In `terraform test`, a run with `command = plan` that creates
  the organization while another organization names one of its tenants or domains fails with
  "Check block assertion known after apply", and a calling test cannot name a check inside a
  module in `expect_failures`. Use `command = apply` for such runs.
- **Import is not verified.** The resource ID format follows the provider's documentation:
  `terraform import 'module.<name>.msgraph_resource.this' /identityGovernance/entitlementManagement/connectedOrganizations/<organization-id>`.
  Without importing the sponsor collections, the first apply with a sponsor list adds the listed
  sponsors and the next apply removes the others.

## Live test status

Live test status: not verified in a licensed tenant. The module is tested with a mock provider
only. These checks are pending, and each needs a licensed tenant and credentials:

1. Create an organization with each identity source type, and with several identity sources in
   one request. Record what Graph reads back for each: the `@odata.type` with or without `#`,
   whether `tenantId`, `domainName` and `displayName` are returned, and whether the next plan is
   empty.
2. Update the identity sources in place: replace a tenant by a domain, add and remove a source,
   and check that the stored list is the one sent.
3. Send a `null` description on create and on update, and read it back.
4. Look up a tenant by its primary domain and by another verified domain, and record the
   response for a domain that belongs to no tenant.
5. Add and remove internal and external sponsors, users and groups, with the `directoryObjects`
   URI; record whether Graph rejects a member user as an external sponsor or a guest as an
   internal one.
6. Create a second organization for a tenant or domain that another organization names, as
   `configured` and as `proposed`, and record whether Graph rejects it.
7. Delete an organization that a policy targets, and one with sponsors.
8. The 403 behaviour under the least privileged roles, and the lookup permission.
9. Import of the organization and of its sponsor collections, and the first plan after it.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |

Notes:

- Microsoft Learn's features-by-license table has no row for connected organizations themselves. They belong to the entitlement management capabilities that Microsoft Entra ID P2 includes, and the table lists internal and external sponsors from the assignee's connected organization as approvers under Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite, so the EM-CORE rule is applied by inference. Sponsors from the assignee's user profile as approvers need Microsoft Entra ID Governance or Microsoft Entra Suite. See [Microsoft Entra ID Governance licensing fundamentals](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#features-by-license).
- The users of a connected organization become guests when their requests are approved. Learn bills the Microsoft Entra ID Governance features that guests use per monthly active user to an Azure subscription linked to the tenant, and does not bill Microsoft Entra ID P2 features. Its list of billable actions includes Sponsor policy is applied to assignment, billed on each successful request when a sponsor is an approver in the policy; whether that covers the internal and external sponsors of a connected organization, which the features table lists under Microsoft Entra ID P2, is not verified. This module creates the organization and its sponsors only; these rules apply to the policies that target the organization or use its sponsors as approvers. See [Microsoft Entra ID Governance licensing for guest users](https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users).
- Guests who sign in are also counted as monthly active users of Microsoft Entra External ID, billed to a linked Azure subscription beyond its free tier; that billing is not modelled here. See [Microsoft Entra External ID pricing and billing overview](https://learn.microsoft.com/en-us/entra/external-id/external-identities-pricing).
- Connected organizations, their configured and proposed states and their sponsors are described in [Manage connected organizations in entitlement management](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-organization).
- The connected organization rules were reviewed against Microsoft Learn on 2026-10-07, which is later than the review date stated above.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| display_name | Display name of the organization; not empty | `string` | n/a | yes |
| identity_sources | At least one `{ type, tenant_id, domain_name, display_name }`: `type` is `tenant` (with a GUID `tenant_id`), `tenant_domain` (with `domain_name`, looked up during the plan, no `display_name`) or `domain` (with `domain_name`); each tenant ID and domain name at most once; sent in order and in place | `list(object)` | n/a | yes |
| description | Description; always sent, as `null` when unset | `string` | `null` | no |
| state | `configured` or `proposed` | `string` | `"configured"` | no |
| internal_sponsor_ids | Object IDs (GUIDs) of the users or groups that are internal sponsors, each at most once; `null` leaves them alone, a list is authoritative, `[]` removes them all | `list(string)` | `null` | no |
| external_sponsor_ids | Object IDs (GUIDs) of the users or groups that are external sponsors, each at most once; `null` leaves them alone, a list is authoritative, `[]` removes them all | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the connected organization; an update keeps it |
| display_name | The display name, as configured |
| state | `configured` or `proposed`, as configured |
| identity_sources | The identity sources as sent, in Graph's shape, with tenant IDs and domain names in lower case |
| internal_sponsor_ids | The managed internal sponsor IDs in lower case, or `null` when they are not managed |
| external_sponsor_ids | The managed external sponsor IDs in lower case, or `null` when they are not managed |
| specific_allowed_target | `{ type = "connectedOrganizationMembers", id }`, one element of an assignment policy's `specific_allowed_targets` |

## Tests

`tests/connected_organization.tftest.hcl` and `tests/identity_source_conflict_on_create.tftest.hcl`
run offline against a mock provider and need Terraform 1.7 or later: `terraform init` and
`terraform test` in this folder. They cover the body of each identity source type and of several
together, the tenant lookup through a mocked data source and its failure, the request, update
method and drift settings, in-place updates that keep the id, the description sent as `null`, the
sponsor collections (urls, lower-case reference ids, an empty list, `null` creating none), the
outputs and `specific_allowed_target`, the conflict check on a create plan, after a create and on
later applies, the duplicate tenant precondition, and every validation. A mock provider evaluates
none of the read-back expressions and has no `collection_type` default before provider 0.6.0, so a
Python test (`tests/test_connected_organizations.py`) ties the exported keys to the expressions
that consume them, checks that the module leaves `collection_type` unset, and checks the
validation messages. There is no live suite yet; see [Live test status](#live-test-status).
